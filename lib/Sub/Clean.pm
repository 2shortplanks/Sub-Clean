package Sub::Clean;

# attribute handing requires 5.008
use 5.008;

use strict;
use warnings;

use namespace::clean;
use Attribute::Handlers;
use B::Hooks::EndOfScope;

sub import {
  use Data::Dumper;
  my $package = caller();
  
  # create a subroutine in their namespace
  eval <<"PERL" or die $@;
  sub ${package}::cleaned :ATTR(CODE,INIT) {
    namespace::clean->clean_subroutines('$package', \*{ \$_[1] }{NAME} );
  }; 1
PERL

  # remove it when they're done compiling
  on_scope_end {
    namespace::clean->clean_subroutines($package, "cleaned");
  };

  return;
}

1;