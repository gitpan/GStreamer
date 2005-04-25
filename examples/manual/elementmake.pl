#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementmake.pl,v 1.1 2005/03/23 20:46:46 kaffeetisch Exp $

# create element
my $element = GStreamer::ElementFactory -> make("fakesrc", "source");
unless ($element) {
  print "Failed to create element of type 'fakesrc'\n";
  exit -1;
}
