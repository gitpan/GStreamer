#!/usr/bin/perl
use strict;
use warnings;
use GStreamer -init;

# $Id: init.pl,v 1.1 2005/03/23 20:46:49 kaffeetisch Exp $

my ($major, $minor, $micro) = GStreamer -> version();
printf "This program is linked against GStreamer %d.%d.%d\n",
       $major, $minor, $micro;
