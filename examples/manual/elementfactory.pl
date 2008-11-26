#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementfactory.pl 29 2005-12-03 00:28:13Z tsch $

# get factory
my $factory = GStreamer::ElementFactory -> find("audiotestsrc");
unless ($factory) {
  print "You don't have the 'audiotestsrc' element installed, go get it!\n";
  exit -1;
}

# display information
printf "The '%s' element is a member of the category %s.\n" .
       "Description: %s\n",
       $factory -> get_name(),
       $factory -> get_klass(),
       $factory -> get_description();
