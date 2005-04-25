#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementlink.pl,v 1.1 2005/03/23 20:46:46 kaffeetisch Exp $

# create elements
my ($source, $filter, $sink) =
  GStreamer::ElementFactory -> make(fakesrc => "source",
                                    identity => "filter",
                                    fakesink => "sink");

# link
$source -> link($filter, $sink);
