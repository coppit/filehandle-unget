#!/usr/bin/perl

use strict;

# For PRIVATE Module::Install extensions
use lib 'private-lib';

use inc::Module::Install;

all_from('lib/FileHandle/Unget.pm');

auto_set_bugtracker;
githubmeta;

include(
  'File::Slurp' => 0,
);

requires(
  'Scalar::Util' => '1.14',
);

test_requires(
  'Test::More' => 0,
  'File::Spec::Functions' => 0,
);

license 'gpl2';
auto_license(holder => 'David Coppit');

enable_verbose_cpan_testing();

WriteAll();
