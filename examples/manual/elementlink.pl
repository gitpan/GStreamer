#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementlink.pl 2 2005-03-23 20:47:28Z tsch $

# create elements
my ($source, $filter, $sink) =
  GStreamer::ElementFactory -> make(fakesrc => "source",
                                    identity => "filter",
                                    fakesink => "sink");

# link
$source -> link($filter, $sink);
