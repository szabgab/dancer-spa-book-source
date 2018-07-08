use strict;
use warnings;
use Data::Dumper qw(Dumper);
use YAML qw(LoadFile);

my $filename = shift or die "Usage: $0 filename.yml\n";
print Dumper LoadFile($filename);

