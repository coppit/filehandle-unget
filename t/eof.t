use strict;
use FileHandle::Unget;
use File::Spec::Functions qw(:ALL);
use Test::More tests => 4;
use File::Temp;

my $filename;

{
  my $fh;
  ($fh, $filename) = File::Temp::tempfile(UNLINK => 1);
  
  print $fh "first line\n";
  print $fh "second line\n";
  close $fh;
}

# Test getline on the end of the file
{
  my $fh = new FileHandle::Unget($filename);

  my $line;
  
  $line = <$fh>;
  # 1
  is($line,"first line\n",'Read first line');

  $line = <$fh>;
  # 2
  is($line,"second line\n",'Read second line');

  $line = <$fh>;
  # 3
  is($line,undef,'EOF getline');

  $fh->close;
}

# Test getlines on the end of the file
{
  my $fh = new FileHandle::Unget($filename);

  my $line;
  
  $line = <$fh>;
  $line = <$fh>;

  my @lines = $fh->getlines();
  # 4
  is($lines[0],undef,'EOF getlines');

  $fh->close;
}
