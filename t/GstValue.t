#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

# $Id: GstValue.t 87 2008-11-26 20:58:26Z tsch $

use Glib qw(TRUE FALSE);
use GStreamer -init;

# Use UTC to make sure the timestamp means the same everywhere.  Hopefully,
# this works on most systems.
$ENV{TZ} = "UTC";
my $time = 999993600; # 2001-09-09, 00:00

my $structure = {
  name => "urgs",
  fields => [
    [fourcc                => "GStreamer::Fourcc"        => "MJPG"],
    [int_range             => "GStreamer::IntRange"      => [23, 42]],
    [double_range          => "GStreamer::DoubleRange"   => [23, 42]],
    [value_list_int        => "GStreamer::ValueList"     => [[23, "Glib::Int"], [42, "Glib::Int"]]],
    [value_list_int_range  => "GStreamer::ValueList"     => [[[23, 42], "GStreamer::IntRange"]]],
    [value_array_int       => "GStreamer::ValueArray"    => [[23, "Glib::Int"], [42, "Glib::Int"]]],
    [value_array_int_range => "GStreamer::ValueArray"    => [[[23, 42], "GStreamer::IntRange"]]],
    [fraction              => "GStreamer::Fraction"      => [23, 42]],
    [fraction_range        => "GStreamer::FractionRange" => [[23, 42], [42, 23]]],
    [date                  => "GStreamer::Date"          => $time]
  ]
};

my $string = GStreamer::Structure::to_string($structure);

# remove trailing semicolon that started to appear sometime in the past
$string =~ s/;\Z//;

my $exptected_string =
    "urgs, "
  . "fourcc=(fourcc)MJPG, "
  . "int_range=(int)[ 23, 42 ], "
  . "double_range=(double)[ 23, 42 ], "
  . "value_list_int=(int){ 23, 42 }, "
  . "value_list_int_range=(int){ [ 23, 42 ] }, "
  . "value_array_int=(int)< 23, 42 >, "
  . "value_array_int_range=(int)< [ 23, 42 ] >, "
  . "fraction=(fraction)23/42, "
  . "fraction_range=(fraction)[ 23/42, 42/23 ], "
  . "date=(GstDate)2001-09-09";

is($string, $exptected_string);
is_deeply(GStreamer::Structure::from_string($string), $structure);
