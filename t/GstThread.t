#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

# $Id: GstThread.t,v 1.1 2005/03/23 20:47:12 kaffeetisch Exp $

use GStreamer -init;

my $thread = GStreamer::Thread -> new("urgs");
isa_ok($thread, "GStreamer::Thread");
is(GStreamer::Thread -> get_current(), undef);
