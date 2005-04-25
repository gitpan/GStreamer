#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: elementget.pl,v 1.1 2005/03/23 20:46:46 kaffeetisch Exp $

my $element = GStreamer::ElementFactory -> make("fakesrc", "source");

printf "The name of the element is '%s'.\n",
       $element -> get("name");
