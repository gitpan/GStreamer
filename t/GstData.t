#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

# $Id: GstData.t,v 1.1 2005/03/23 20:46:55 kaffeetisch Exp $

use GStreamer -init;

my $data = GStreamer::Buffer -> new();
isa_ok($data, "GStreamer::Data");
ok($data -> is_writable());
