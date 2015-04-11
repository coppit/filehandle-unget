use strict;
use FileHandle::Unget;
use File::Spec::Functions qw(:ALL);
use Test::More tests => 1;
use File::Temp;

my $filename;
{
  my $fh;
  ($fh, $filename) = File::Temp::tempfile(UNLINK => 1);
  close $fh;
}

# Test "print" and "syswrite" to write/append a file, close $fh
{
  my $fh = new FileHandle::Unget(">$filename");
  print $fh "first line\n";

  # 1
  like(fileno($fh), qr/^\d+$/, 'fileno()');

  close $fh;
}

