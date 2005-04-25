#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4;

# $Id: GstQuery.t,v 1.1 2005/03/23 20:46:57 kaffeetisch Exp $

use GStreamer -init;

is(GStreamer::QueryType::register("urgs", "Urgs!"), "urgs");
is(GStreamer::QueryType::get_by_nick("total"), "total");
is_deeply([GStreamer::QueryType::get_details("urgs")], ["urgs", "urgs", "Urgs!"]);
is_deeply((GStreamer::QueryType::get_definitions())[-1], ["urgs", "urgs", "Urgs!"]);
