#!/usr/bin/perl

use strict;
use inc::Module::Install;
use File::Slurp;

all_from('lib/FileHandle/Unget.pm');

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

WriteAll();

if (auto_tester) {
  my $code = read_file('Makefile');
  $code =~ s/TEST_VERBOSE\s*=\s*0/TEST_VERBOSE=1/ or die "Couldn't enable verbose mode in Makefile";
  write_file('Makefile', $code);
}
