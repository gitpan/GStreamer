#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 20;

# $Id: GstClock.t 103 2009-01-18 12:53:21Z tsch $

use Glib qw(TRUE FALSE);
use GStreamer qw(-init GST_SECOND);

my $element = GStreamer::ElementFactory -> make("pipeline", "src");

SKIP: {
  skip 'failed to create a pipeline element', 20
    unless defined $element;

  my $clock = $element -> provide_clock();

  skip 'failed to find a clock', 20
    unless defined $clock;

  is($clock -> set_resolution(1000), 0);
  is($clock -> get_resolution(), 1000);

  ok($clock -> get_time() >= 0);

  $clock -> set_calibration(0, 2, 3, 4);
  is_deeply([$clock -> get_calibration()], [0, 2, 3, 4]);

  SKIP: {
    skip "master clock tests", 2
      unless undef; # FIXME

    my $master_element = GStreamer::ElementFactory -> make("alsamixer", "sink");
    my $master = $element -> provide_clock();

    ok($clock -> set_master($master));
    is($clock -> get_master(), $master);
  }

  my ($result, $r) = $clock -> add_observation(23, 42);
  ok(defined $result);
  ok(defined $r);

  ok($clock -> get_internal_time() >= 0);
  ok($clock -> adjust_unlocked(23) >= 0);

  my $id = $clock -> new_single_shot_id($clock -> get_time());
  isa_ok($id, "GStreamer::ClockID");

  $id = $clock -> new_periodic_id($clock -> get_time(), GST_SECOND);
  isa_ok($id, "GStreamer::ClockID");

  ok($id -> get_time() > 0);
  $id -> unschedule();

  # wait()
  {
    my $id = $clock -> new_periodic_id($clock -> get_time(), GST_SECOND);
    my ($return, $jitter) = $id -> wait();
    is($return, "ok");
    ok($jitter >= 0);
  }

  # wait_async
  SKIP: {
    skip 'wait_async is broken currently', 5;

    my $id = $clock -> new_periodic_id($clock -> get_time(), GST_SECOND);

    my $loop = Glib::MainLoop -> new();

    my $been_here = 0;
    my $status = $id -> wait_async(sub {
      my ($clock, $time, $id, $data) = @_;

      return TRUE if $been_here++;

      isa_ok($clock, "GStreamer::Clock");
      ok($time > 0);
      isa_ok($id, "GStreamer::ClockID");
      is($data, "bla");

      $loop -> quit();

      return TRUE;
    }, "bla");
    is($status, "ok");

    # It might happen that the callback has already been invoked.  If so, don't
    # run the main loop or we will cause a dead lock!
    if (!$been_here) {
      $loop -> run();
    }
  }
}
