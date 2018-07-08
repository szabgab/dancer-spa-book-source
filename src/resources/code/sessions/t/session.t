use strict;
use warnings;
use 5.010;

use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common qw(GET POST);
use FindBin;


my $app = do "$FindBin::Bin/../bin/app.psgi";
is( ref $app, 'CODE', 'Got app' );
my $test = Plack::Test->create($app);

subtest main => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    is( $res->header('Content-type'), 'text/html; charset=UTF-8' );
    like( $res->content, qr{<script src="/session.js"></script>}, 'Content looks ok' );
};

subtest api_get_null => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/api/code' );
    is( $res->header('Content-type'), 'application/json; charset=UTF-8' );
    ok( $res->is_success, '[GET /api/code] successful' );
    is( $res->content, '{"result":null}', 'API' );
};

my $cookie;
subtest api_set_code => sub {
    plan tests => 6;

    my $res  = $test->request( POST '/api/code', { code => 'abc' } );
    is( $res->header('Content-type'), 'application/json; charset=UTF-8' );
    ok( $res->is_success, '[SET /api/code] successful' );
    is( $res->content, '{"result":"set"}', 'API' );

    # the order of the fields as Dancer2 returns is not fixed.
    my $cookie_header = $res->header('set-cookie');
    like( $cookie_header, qr{dancer.session=([^;]+);} );
    like( $cookie_header, qr{Path=/} );
    like( $cookie_header, qr{HttpOnly} );
    ($cookie) = $cookie_header =~ m{(dancer.session=\S+);};
    diag( $cookie );
};

subtest api_get_code => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/api/code', COOKIE => $cookie );
    is( $res->header('Content-type'), 'application/json; charset=UTF-8' );
    ok( $res->is_success, '[GET /api/code] successful' );
    is( $res->content, '{"result":"abc"}', 'API' );
};


