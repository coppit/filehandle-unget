use strict;
use lib 'lib';
use FileHandle::Unget;
use Data::Dumper;
use Test;

plan (tests => 1);

my $fh  = new FileHandle::Unget($0);

ok (Dumper($fh),"\$VAR1 = bless( \\*Symbol::GEN0, 'FileHandle::Unget' );\n");

$fh->close;