use strict;
use lib 'lib';
use FileHandle::Unget;
use Test;

plan (tests => 2);

#-------------------------------------------------------------------------------

{
  my ($out, $in) = FileHandle::Unget::pipe;
  die unless ref $out && ref $in;

  my $pid = fork();

  if(defined($pid))
  {
    # Prevent the child from reporting as well
    # 1
    ok(1) if $pid;
  }
  else
  {
    # 1
    ok(0), exit unless defined($pid);
  }

  # In parent
  if ($pid)
  {
    close $in;

    local $/ = undef;
    my $results = <$out>;

    # 2
    ok($results,"Some info from the child\nSome more\n");

    exit;
  }
  # In child
  else
  {
    print $in "Some info from the child\nSome more\n";
    exit;
  }
}