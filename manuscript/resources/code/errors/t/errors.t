use strict;
use warnings;
use 5.010;

use Test::More tests => 6;
use Plack::Test;
use HTTP::Request::Common qw(GET POST);
use FindBin;

my $app = do "$FindBin::Bin/../bin/errors.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

subtest root => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    is $res->header('Content-type'), 'text/html; charset=UTF-8';
    ok( index( $res->content, 'Showing errors') >= 0, 'Content looks ok' );
};

subtest exception => sub {
    plan tests => 4;

    my $res  = $test->request( POST '/calc', { a => 42, b => 0 } );
    ok( !$res->is_success, '[POST /calc] successful' );
    is $res->header('Content-type'), 'text/html; charset=UTF-8';
    is $res->status_line, '500 Internal Server Error';
    ok( index( $res->content, '<h1>Error 500 - Internal Server Error</h1>') >= 0, 'Content looks ok' );
};


subtest api_static_get => sub {
    plan tests => 3;

    my $res  = $test->request( GET '/api/static');
    ok( $res->is_success, '[GET /api/static] successful' );
    is $res->header('Content-type'), 'application/json; charset=UTF-8';
    is $res->content, '{"result":"fixed content"}', 'fixed content';
};

subtest api_exception => sub {
    plan tests => 4;

    my $res  = $test->request( POST '/api/calc', { x => 23, y => 0 });
    ok( !$res->is_success, '[POST /api/calc] failed as expected' );
    is $res->status_line, '500 Internal Server Error';
    is $res->header('Content-type'), 'application/json; charset=UTF-8';
    is $res->content, '{"result":"Internal Error"}', 'fixed content';
};

subtest api_error => sub {
    plan tests => 4;

    my $res  = $test->request( POST '/api/calc', { x => 23, y => 'qqrq' });
    ok( !$res->is_success, '[POST /api/calc] failed as expected' );
    is $res->status_line, '400 Bad Request';
    is $res->header('Content-type'), 'application/json; charset=UTF-8';
    is $res->content, q({"result":"The value 'qqrq' is not a number"}), 'content of error message';
};

