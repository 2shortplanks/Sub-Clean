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
  
  eval <<"PERL" or die $@;
  sub ${package}::cleaned :ATTR(CODE,INIT) {
    no strict 'refs';
    delete \$${package}::{ \*{ \$_[1] }{NAME} };
  }; 1
PERL

  on_scope_end {
    eval "delete \$${package}::{cleaned}";
  };

  return;
}

1;