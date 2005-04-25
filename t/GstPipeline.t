#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 1;

# $Id: GstPipeline.t,v 1.1 2005/03/23 20:46:55 kaffeetisch Exp $

use GStreamer -init;

my $pipeline = GStreamer::Pipeline -> new("urgs");
isa_ok($pipeline, "GStreamer::Pipeline");
