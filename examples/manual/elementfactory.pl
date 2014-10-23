#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementfactory.pl,v 1.1 2005/03/23 20:46:46 kaffeetisch Exp $

# get factory
my $factory = GStreamer::ElementFactory -> find("sinesrc");
unless ($factory) {
  print "You don't have the 'sinesrc' element installed, go get it!\n";
  exit -1;
}

# display information
printf "The '%s' element is a member of the category %s.\n" .
       "Description: %s\n",
       $factory -> get_name(),
       $factory -> get_klass(),
       $factory -> get_description();
