#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 19;

# $Id: GstPlugin.t,v 1.3 2005/06/12 17:29:15 kaffeetisch Exp $

use Glib qw(TRUE FALSE);
use GStreamer -init;

my $plugin = GStreamer::RegistryPool -> find_plugin("volume");
is($plugin -> get_name(), "volume");
ok(defined $plugin -> get_description());
ok(defined $plugin -> get_filename());
ok(defined $plugin -> get_license());
ok(defined $plugin -> get_package());
ok(defined $plugin -> get_origin());

SKIP: {
  skip "new stuff", 1
    unless GStreamer -> CHECK_VERSION(0, 8, 8);

  ok(defined $plugin -> get_version());
}

ok(!$plugin -> is_loaded());

sub feature_filter {
  my ($feature, $data) = @_;

  isa_ok($feature, "GStreamer::PluginFeature");
  is($data, "bla");

  return TRUE;
}

my @features = $plugin -> feature_filter(\&feature_filter, TRUE, "bla");
is($#features, 0);
isa_ok($features[0], "GStreamer::PluginFeature");

ok($plugin -> name_filter("volume"));
isa_ok(($plugin -> get_feature_list())[0], "GStreamer::PluginFeature");
isa_ok($plugin -> find_feature("volume", "GStreamer::ElementFactory"), "GStreamer::PluginFeature");

$plugin -> add_feature($plugin -> find_feature("volume", "GStreamer::ElementFactory"));

ok($plugin -> unload_plugin());

my $so = "/usr/lib/gstreamer-0.8/libgstossaudio.so";

SKIP: {
  skip "OSS plugin not found", 3
    unless GStreamer::Plugin::check_file($so);

  my $plugin = GStreamer::Plugin::load_file($so);
  isa_ok($plugin, "GStreamer::Plugin");

  ok(GStreamer::Plugin::load("ossaudio"));
  ok(GStreamer::Library::load("ossaudio"));
}
