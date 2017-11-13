use strict;
use warnings;
use Test::More;
use Path::Tiny;
use File::Find::Rule;

#my @md_files = glob "manuscript/*.md";
#diag explain \@md_files;
#plan tests => scalar @md_files;

my $rule = File::Find::Rule->new;
$rule->file();
$rule->not( $rule->new->name( '*.png', '*.jpg', '*.bak' ) );
my @all_files = $rule->in( 'manuscript', 't' );
#diag explain \@all_files;

#my @perl_files = File::Find::Rule->file()
#                          ->name( '*.pm', '*.pl', '*.psgi' )
#                          ->in( '.' );
#diag explain \@perl_files;

for my $file (@all_files) {
    #ok -e $file;
    my @content = path($file)->lines_utf8;
    for my $line (@content) {
        unlike $line, qr/\s\n$/, "Trailing spces in '$file'";
    }
}


done_testing();
