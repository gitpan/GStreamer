#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: ghostpad.pl,v 1.1 2005/03/23 20:46:46 kaffeetisch Exp $

# create element, add to bin, add ghostpad
my $sink = GStreamer::ElementFactory -> make("fakesink", "sink");
my $bin = GStreamer::Bin -> new("mybin");
$bin -> add($sink);
$bin -> add_ghost_pad($sink -> get_pad("sink"), "sink");
