#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

# $Id: GstEvent.t,v 1.1 2005/03/23 20:46:55 kaffeetisch Exp $

use GStreamer -init;

my $event = GStreamer::Event -> new("interrupt");
isa_ok($event, "GStreamer::Event");
is($event -> type(), "interrupt");
