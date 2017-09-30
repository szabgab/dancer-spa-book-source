use strict;
use warnings;
use 5.010;

use FindBin ();

use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common qw(GET);

my $app = do "$FindBin::Bin/hello_world_spa.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

my $res  = $test->request( GET '/' );
ok( $res->is_success, '[GET /] successful' );
ok( index($res->content, 'Hello <span id="result"></span> World') > 0, 'Content looks ok' );


my $ajax  = $test->request( GET '/api/greeting' );
ok( $ajax->is_success, '[GET /api/greeting] successful' );
is( $ajax->content, '{"result":"Ajax"}', 'Content looks ok' );

