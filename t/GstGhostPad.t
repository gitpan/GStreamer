#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 8;

# $Id: GstGhostPad.t,v 1.1 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $pad = GStreamer::Pad -> new("urgs", "src");

my $gpad = GStreamer::GhostPad -> new("urgs", $pad);
isa_ok($gpad, "GStreamer::GhostPad");
is($gpad -> get_target(), $pad);

$gpad = GStreamer::GhostPad -> new(undef, $pad);
isa_ok($gpad, "GStreamer::GhostPad");
is($gpad -> get_target(), $pad);

$gpad = GStreamer::GhostPad -> new_no_target("urgs", "src");
isa_ok($gpad, "GStreamer::GhostPad");
is($gpad -> get_target(), undef);

ok($gpad -> set_target($pad));
is($gpad -> get_target(), $pad);
