use common::sense;

use Regexp::Grammars;
use Data::Dumper;


my $parser = qr{
  ^ <expression> $

  <token: ws>
    (?: \s++ | [#][^\n]*\n | [/][*] .*? [*][/] )*

  <rule: expression>
    <term_left=term> <binary_op> <term_right=term> | <term>

  <rule: term>
    <number> | \( <expression> \)

  <token: number>
    \d+

  <token: binary_op>
    [+-/*]
}xs;




if ($ARGV[0] =~ $parser) {
  my $ast = \%/;
  print Dumper($ast);
  print "PREFIX: " . render_prefix($ast) . "\n";
} else {
  die "bad parse: " . join(",",@!) unless $ARGV[0] =~ $parser;
}




sub render_prefix {
  my $inp = shift;

  if (exists $inp->{number}) {
    return $inp->{number};
  } elsif (exists $inp->{binary_op}) {
    return "($inp->{binary_op} " .
           render_prefix($inp->{term_left}) .
           " " .
           render_prefix($inp->{term_right}) .
           ")";
  } elsif (exists $inp->{expression}) {
    return render_prefix($inp->{expression});
  } elsif (exists $inp->{term}) {
    return render_prefix($inp->{term});
  }
}
