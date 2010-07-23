package MyTestingModule;

use strict;
use warnings;

use Sub::Clean;

sub foo {
  my $class = shift;
  return bar();
}

sub bar : cleaned {
  return "ok";
}

# little check to see that bar is still availble here
die unless bar() eq "ok";

1;