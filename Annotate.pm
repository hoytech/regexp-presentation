package Annotate;

use strict;

use Text::Unidecode;


sub annotate_unidecode {
  my $val = shift;

  $val =~ s{ ( \P{ASCII} \P{Latin}* ) }
           {
             my $match = $1;
             "$match(" . unidecode($match) . ")"
           }egx;

  return $val;
}

1;
