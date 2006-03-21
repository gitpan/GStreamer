#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

# $Id: GstIndexFactory.t,v 1.1 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $factory = GStreamer::IndexFactory -> new("urgs", "Urgs!", "GStreamer::Index");
isa_ok($factory, "GStreamer::IndexFactory");

# FIXME
# isa_ok($factory -> create(), "GStreamer::Index");

is(GStreamer::IndexFactory -> find("urgs"), undef);
is(GStreamer::IndexFactory -> make("urgs"), undef);

$factory -> destroy();