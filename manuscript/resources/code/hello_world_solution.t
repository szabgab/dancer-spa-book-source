use strict;
use warnings;
use 5.010;

use FindBin ();

use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common qw(GET);

my $app = do "$FindBin::Bin/hello_world_solution.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

my $res  = $test->request( GET '/' );
ok( $res->is_success, '[GET /] successful' );
is( $res->content, 'Hello World <a href="/about">About</a>', 'Content looks ok' );

my $about  = $test->request( GET '/about' );
ok( $about->is_success, '[GET /about] successful' );
is( $about->content, 'By Gabor Szabo <a href="/">main</a>', 'Content looks ok' );


