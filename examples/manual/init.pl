#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: init.pl 2 2005-03-23 20:47:28Z tsch $

my ($major, $minor, $micro) = GStreamer -> version();
printf "This program is linked against GStreamer %d.%d.%d\n",
       $major, $minor, $micro;
