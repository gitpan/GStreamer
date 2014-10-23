#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 15;

# $Id: GstIndex.t,v 1.4 2008/03/23 16:49:25 kaffeetisch Exp $

use GStreamer -init;

my $index = GStreamer::Index -> new();
isa_ok($index, "GStreamer::Index");

$index -> commit(23);

is($index -> new_group(), 1);
ok($index -> set_group(1));
is($index -> get_group(), 1);

$index -> set_certainty("fuzzy");
is($index -> get_certainty(), "fuzzy");

$index -> set_filter(sub { warn @_; 1; }, "bla");

my $object = GStreamer::ElementFactory -> make("alsasink", "sink");
SKIP: {
  skip 'failed to create an alsasink', 5
    unless defined $object;

  $index -> set_resolver(sub {
    my ($index, $element, $data) = @_;

    isa_ok($index, "GStreamer::Index");
    isa_ok($element, "GStreamer::Element");
    is($data, "blub");

    return "urgs";
  }, "blub");

  my $id = $index -> get_writer_id($object);
  is($id, 1);

  # Seems to be unimplemented.
  my $entry = $index -> add_object(25, "urgs", $object);
  is($entry, undef);
}

my $entry = $index -> add_format(23, "bytes");
isa_ok($entry, "GStreamer::IndexEntry");

$entry = $index -> add_association(24, "key-unit", bytes => 12, bytes => 13);
isa_ok($entry, "GStreamer::IndexEntry");
is($entry -> assoc_map("bytes"), 12);

$entry = $index -> add_id(26, "sgru");
isa_ok($entry, "GStreamer::IndexEntry");

$entry = $index -> get_assoc_entry(24, "exact", "key-unit", bytes => 12);
is($entry, undef);
