use strict;
use FileHandle::Unget;
use File::Spec::Functions qw(:ALL);
use Test::More tests => 1;
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

  binmode $fh;

  my $string;
  read($fh,$string,5);
  $fh->ungets($string);

  my $line;

  my $bytes_read = 0;
  
  while($line = <$fh>)
  {
    $bytes_read += length $line;

    last if $bytes_read > -s $filename;
  }

  # 1
  is($bytes_read,-s $filename, 'Loop bug');

  $fh->close;
}
