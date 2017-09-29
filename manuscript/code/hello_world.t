use strict;
use warnings;
use 5.010;

use Test::More tests => 3;
use Plack::Test;
use HTTP::Request::Common;

use Cwd qw(abs_path);
use File::Basename qw(dirname);

my $dir = dirname abs_path $0;

my $app = do "$dir/hello_world.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

my $res  = $test->request( GET '/' );
ok( $res->is_success, '[GET /] successful' );
is( $res->content, 'Hello World', 'Content looks ok' );

