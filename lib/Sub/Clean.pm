package Sub::Clean;

# attribute handing requires 5.008
use 5.008;

use strict;
use warnings;

use Attribute::Handlers;
use B::Hooks::EndOfScope;

use Exporter;

use Data::Dumper;

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
    #TODO;
  };

  return;
}

1;