#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementmake.pl 2 2005-03-23 20:47:28Z tsch $

# create element
my $element = GStreamer::ElementFactory -> make("fakesrc", "source");
unless ($element) {
  print "Failed to create element of type 'fakesrc'\n";
  exit -1;
}
