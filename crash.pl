## This will crash perl on linux if perl < 5.17.5

use strict;
use File::Map;

File::Map::map_file(my $gap_page, "/dev/zero", "<", 0, 4096);
File::Map::protect($gap_page, File::Map::PROT_NONE);

File::Map::map_file(my $string, "/dev/zero", "<", 0, 4096);

$string =~ /.$/; ## boom
