#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

# $Id: GstTypeFindFactory.t,v 1.1 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $factory = (GStreamer::TypeFindFactory -> get_list())[0];
isa_ok($factory, "GStreamer::TypeFindFactory");
ok(defined $factory -> get_extensions());
isa_ok($factory -> get_caps(), "GStreamer::Caps");
