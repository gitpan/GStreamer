#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: bin.pl 2 2005-03-23 20:47:28Z tsch $

# create
my $pipeline = GStreamer::Pipeline -> new("my_pipeline");
my $bin = GStreamer::Pipeline -> new("my_bin");
my ($source, $sink) =
  GStreamer::ElementFactory -> make(fakesrc => "source",
                                    fakesink => "sink");

# set up pipeline
$bin -> add($source, $sink);
$pipeline -> add($bin);
$source -> link($sink);
