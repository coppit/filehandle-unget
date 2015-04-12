#!/usr/bin/perl

use strict;
use inc::Module::Install;

all_from('lib/FileHandle/Unget.pm');

githubmeta;

requires(
  'Scalar::Util' => '1.14',
);

test_requires(
  'Test::More' => 0,
  'File::Spec::Functions' => 0,
);

WriteAll();
