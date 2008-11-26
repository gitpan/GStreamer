#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementget.pl 2 2005-03-23 20:47:28Z tsch $

my $element = GStreamer::ElementFactory -> make("fakesrc", "source");

printf "The name of the element is '%s'.\n",
       $element -> get("name");
