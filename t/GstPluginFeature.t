#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 5;

# $Id: GstPluginFeature.t,v 1.2 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $feature = GStreamer::ElementFactory -> find("alsasink");
isa_ok($feature, "GStreamer::PluginFeature");

isa_ok($feature = $feature -> load(), "GStreamer::PluginFeature");

$feature -> set_rank(23);
is($feature -> get_rank(), 23);

$feature -> set_name("alsasink");
is($feature -> get_name(), "alsasink");

ok($feature -> check_version(0, 0, 0));
