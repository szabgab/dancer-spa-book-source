use strict;
use warnings;
use 5.010;

use Test::More tests => 3;
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
    is $res->header('Content-type'), 'text/html; charset=UTF-8';
    is( $res->content, 'Hello World <a href="/api/hello">API</a>', 'Content looks ok' );
};

subtest api => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/api/hello' );
    is $res->header('Content-type'), 'application/json; charset=UTF-8';
    ok( $res->is_success, '[POST /api/hello] successful' );
    is $res->content, '{"result":"Hello API"}', 'API'
};

