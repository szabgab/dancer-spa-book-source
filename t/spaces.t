use strict;
use warnings;
use Test::More;
use Path::Tiny;

my @md_files = glob "manuscript/*.md";
#diag explain \@md_files;
#plan tests => scalar @md_files;

for my $file (@md_files) {
    #ok -e $file;
    my @content = path($file)->lines_utf8;
    for my $line (@content) {
        unlike $line, qr/\s\n$/, "Trailing spces in '$file'";
    }
}

done_testing();
