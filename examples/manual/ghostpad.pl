#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: ghostpad.pl,v 1.2 2005/12/03 00:28:13 kaffeetisch Exp $

# create element, add to bin, add ghostpad
my $sink = GStreamer::ElementFactory -> make("fakesink", "sink");
my $bin = GStreamer::Bin -> new("mybin");
$bin -> add($sink);

my $pad = $sink -> get_pad("sink");
$bin -> add_pad(GStreamer::GhostPad -> new("sink", $pad));
