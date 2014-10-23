#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 21;

# $Id: GstRegistry.t,v 1.5 2007/01/31 19:04:48 kaffeetisch Exp $

use Glib qw(TRUE FALSE);
use GStreamer -init;

my $registry = GStreamer::Registry -> get_default();
isa_ok($registry, "GStreamer::Registry");

$registry -> scan_path(".");
is_deeply([$registry -> get_path_list()], []);

my $plugin = GStreamer::Plugin::load_by_name("alsa");
ok($registry -> add_plugin($plugin));

my $feature = GStreamer::ElementFactory -> find("alsasink");
ok($registry -> add_feature($feature));

isa_ok(($registry -> get_plugin_list())[0], "GStreamer::Plugin");

sub plugin_filter {
  my ($plugin, $data) = @_;

  isa_ok($plugin, "GStreamer::Plugin");
  is($data, "bla");

  return TRUE;
}

my @plugins = $registry -> plugin_filter(\&plugin_filter, TRUE, "bla");
is($#plugins, 0);
isa_ok($plugins[0], "GStreamer::Plugin");

sub feature_filter {
  my ($feature, $data) = @_;

  isa_ok($feature, "GStreamer::PluginFeature");
  is($data, "bla");

  return TRUE;
}

my @features = $registry -> feature_filter(\&feature_filter, TRUE, "bla");
is($#features, 0);
isa_ok($features[0], "GStreamer::PluginFeature");

isa_ok(($registry -> get_feature_list("GStreamer::ElementFactory"))[0], "GStreamer::PluginFeature");
isa_ok(($registry -> get_feature_list_by_plugin("alsa"))[0], "GStreamer::PluginFeature");

isa_ok($registry -> find_plugin("volume"), "GStreamer::Plugin");
isa_ok($registry -> find_feature("volume", "GStreamer::ElementFactory"), "GStreamer::PluginFeature");

is($registry -> lookup("..."), undef);
is($registry -> lookup_feature("..."), undef);

ok($registry -> xml_write_cache("tmp"));
ok($registry -> xml_read_cache("tmp"));
unlink "tmp";

$registry -> remove_feature($feature);
$registry -> remove_plugin($plugin);
