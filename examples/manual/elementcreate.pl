#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementcreate.pl 2 2005-03-23 20:47:28Z tsch $

# create element, method #2
my $factory = GStreamer::ElementFactory -> find("fakesrc");
unless ($factory) {
  print "Failed to find factory of type 'fakesrc'\n";
  exit -1;
}

my $element = $factory -> create("source");
unless ($element) {
  print "Failed to create element, even though its factory exists!\n";
  exit -1;
}
