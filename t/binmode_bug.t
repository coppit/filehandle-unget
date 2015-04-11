use strict;
use FileHandle::Unget;
use File::Spec::Functions qw(:ALL);
use Test::More tests => 2;
use Config;
use File::Temp;

my $path_to_perl = $Config{perlpath};

TODO:
{
  if ($^O eq 'Win32')
  {
    if (require Win32)
    {
      local $TODO = 'This test is known to fail on your version of Windows'
        unless Win32::GetOSName() eq 'Win2000';
    }
    else
    {
      local $TODO = 'This test may fail on your version of Windows'
    }
  }

  my $filename;

  {
    my $fh;

    ($fh, $filename) = File::Temp::tempfile(UNLINK => 1);
    
    binmode $fh;
    print $fh "first line\n";
    print $fh "second line\n";
    print $fh "a line\n" x 1000;
    close $fh;
  }

  # Test eof followed by binmode for streams (fails under Windows)
  {
    my $fh = new FileHandle::Unget("$path_to_perl -e \"open F, '$filename';binmode STDOUT;print <F>\" |");

    print '' if eof($fh);
    binmode $fh;

    # 1
    is(scalar <$fh>,"first line\n");

    # 2
    is(scalar <$fh>,"second line\n");

    $fh->close;
  }
}
