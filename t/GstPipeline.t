#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 5;

# $Id: GstPipeline.t,v 1.2 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $pipeline = GStreamer::Pipeline -> new("urgs");
isa_ok($pipeline, "GStreamer::Pipeline");

isa_ok($pipeline -> get_bus(), "GStreamer::Bus");

$pipeline -> set_new_stream_time(23);
is($pipeline -> get_last_stream_time(), 23);

my $clock = $pipeline -> get_clock();
isa_ok($clock, "GStreamer::Clock");

$pipeline -> set_clock($clock);
is($pipeline -> get_clock(), $clock);

$pipeline -> auto_clock();
