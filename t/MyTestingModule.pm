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

1;