use strict;
use warnings;
use 5.010;

use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common qw(GET POST);
use FindBin;

my $app = do "$FindBin::Bin/errors.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

subtest root => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    is $res->header('Content-type'), 'text/html; charset=UTF-8';
    ok( index( $res->content, 'Errors') >= 0, 'Content looks ok' );
};

subtest exception => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/die' );
    ok( !$res->is_success, '[GET /die] successful' );
    is $res->header('Content-type'), 'text/html; charset=UTF-8';
    ok( index( $res->content, '<h1>Error 500 - Internal Server Error</h1>') >= 0, 'Content looks ok' );
};


subtest api_static_get => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/api/static');
    ok( $res->is_success, '[GET /api/static] successful' );
    is $res->header('Content-type'), 'application/json; charset=UTF-8';
    is $res->content, '{"result":"fixed content"}', 'fixed content';
};

subtest api_die_get => sub {
    plan tests => 4;

    my $res  = $test->request( GET '/api/die');
    ok( !$res->is_success, '[GET /api/die] successful' );
    is $res->status_line, '500 Internal Server Error';
    is $res->header('Content-type'), 'application/json; charset=UTF-8';
    is $res->content, '{"result":"Internal Error"}', 'fixed content';
};

