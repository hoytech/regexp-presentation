## This will crash perl on linux if perl < 5.17.5

use strict;

use File::Map qw/map_file protect PROT_NONE/;

map_file(my $gap_page, "/dev/zero", "<", 0, 4096);
protect($gap_page, PROT_NONE);

map_file(my $string, "/dev/zero", "<", 0, 4096);

$string =~ /.$/; ## boom
