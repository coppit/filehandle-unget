use strict;
use FileHandle;
use FileHandle::Unget;
use File::Spec::Functions qw(:ALL);
use Test::More tests => 5;
use File::Temp;

my $filename;

{
  my $fh;
  ($fh, $filename) = File::Temp::tempfile(UNLINK => 1);

  print "Writing file $filename\n";

  print $fh "first line\n";
  print $fh "second line\n";
  close $fh;
}

# Test ungetc'ing and reading a line of data
{
  my $fh = new FileHandle::Unget($filename);

  my $line = <$fh>;

  $fh->ungetc(ord("\n"));
  $fh->ungetc(ord("d"));
  $fh->ungetc(ord("e"));
  $fh->ungetc(ord("t"));
  $fh->ungetc(ord("r"));
  $fh->ungetc(ord("e"));
  $fh->ungetc(ord("s"));
  $fh->ungetc(ord("n"));
  $fh->ungetc(ord("i"));

  $line = <$fh>;

  # 1
  is($line, "inserted\n",'Ungetc');

  $line = <$fh>;
  # 2
  is($line, "second line\n",'getline()');

  $fh->close;
}

# Test ungetc'ing and read'ing some bytes of data
{
  my $fh = new FileHandle::Unget($filename);

  my $line = <$fh>;

  $fh->ungetc(ord("\n"));
  $fh->ungetc(ord("d"));
  $fh->ungetc(ord("e"));
  $fh->ungetc(ord("t"));
  $fh->ungetc(ord("r"));
  $fh->ungetc(ord("e"));
  $fh->ungetc(ord("s"));
  $fh->ungetc(ord("n"));
  $fh->ungetc(ord("i"));

  read($fh, $line, 6);
  # 3
  is($line, "insert", 'read() after insert');

  $line = <$fh>;
  # 4
  is($line, "ed\n", 'getline() 1');

  $line = <$fh>;
  # 5
  is($line, "second line\n", 'getline() 2');

  $fh->close;
}

