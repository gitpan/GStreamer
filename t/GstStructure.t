#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 8;

# $Id: GstStructure.t,v 1.1 2005/03/23 20:47:12 kaffeetisch Exp $

use Glib qw(TRUE FALSE);
use GStreamer -init;

my $structure_one = {
  name => "urgs",
  fields => [
    [field_one => "Glib::String" => "urgs"],
    [field_two => "Glib::Int" => 23]
  ]
};

my $structure_two = {
  name => "sgru",
  fields => [
    [field_one => "Glib::String" => "sgru"],
    [field_two => "Glib::Int" => 42]
  ]
};

my $caps = GStreamer::Caps -> new_full($structure_one);
isa_ok($caps, "GStreamer::Caps");

$caps -> append_structure($structure_two);
is($caps -> get_size(), 2);

is_deeply($caps -> get_structure(0), $structure_one);
is_deeply($caps -> get_structure(1), $structure_two);

my $string_one = GStreamer::Structure::to_string($structure_one);
my $string_two = GStreamer::Structure::to_string($structure_two);

is($string_one, "urgs, field_one=(string)urgs, field_two=(int)23");
is($string_two, "sgru, field_one=(string)sgru, field_two=(int)42");

is_deeply((GStreamer::Structure::from_string($string_one))[0], $structure_one);
is_deeply((GStreamer::Structure::from_string($string_two))[0], $structure_two);
