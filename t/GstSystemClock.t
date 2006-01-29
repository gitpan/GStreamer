#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

# $Id: GstSystemClock.t,v 1.1 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $clock = GStreamer::SystemClock -> obtain();
isa_ok($clock, "GStreamer::SystemClock");
isa_ok($clock, "GStreamer::Clock");
