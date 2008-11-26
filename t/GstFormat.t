#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

# $Id: GstFormat.t 29 2005-12-03 00:28:13Z tsch $

use GStreamer -init;

is(GStreamer::Format::register("urgs", "Urgs!"), "urgs");
is(GStreamer::Format::get_by_nick("bytes"), "bytes");
is_deeply([GStreamer::Format::get_details("urgs")], ["urgs", "urgs", "Urgs!"]);
