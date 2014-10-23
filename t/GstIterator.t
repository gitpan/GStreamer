#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 32;

# $Id: GstIterator.t,v 1.1 2005/12/03 00:28:13 kaffeetisch Exp $

use GStreamer -init;

my $bin = GStreamer::Bin -> new("urgs");
my $factory = GStreamer::ElementFactory -> find("alsasink");

my $element_one = $factory -> create("sink one");
my $element_two = $factory -> create("sink two");
my $element_three = $factory -> create("sink three");
my $element_four = $factory -> create("sink four");

$bin -> add($element_one, $element_two, $element_three, $element_four);

foreach ($bin -> iterate_elements(),
         $bin -> iterate_sorted(),
         $bin -> iterate_recurse(),
         $bin -> iterate_sinks()) {
  isa_ok($_, "GStreamer::Iterator");
  isa_ok($_, "ARRAY");
  is($#$_, 3);
  is($_ -> [0], $element_four);
  is($_ -> [1], $element_three);
  is($_ -> [2], $element_two);
  is($_ -> [3], $element_one);
}

my $iter = $bin -> iterate_elements();
while ($_ = $iter -> next()) {
  isa_ok($_, "GStreamer::Element");
}
