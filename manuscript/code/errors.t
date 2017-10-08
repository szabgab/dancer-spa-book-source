use strict;
use warnings;
use 5.010;

use Test::More tests => 4;
use Plack::Test;
use HTTP::Request::Common qw(GET POST);

use Cwd qw(abs_path);
use File::Basename qw(dirname);

my $dir = dirname abs_path $0;

my $app = do "$dir/errors.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

subtest root => sub {
    plan tests => 2;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    ok( index( $res->content, 'Errors') >= 0, 'Content looks ok' );
};

subtest static_get => sub {
    plan tests => 2;

    my $res  = $test->request( GET '/api/static');
    ok( $res->is_success, '[GET /api/static] successful' );
    is $res->content, '{"result":"fixed content"}', 'fixed content';
};

subtest die_get => sub {
    plan tests => 2;

    my $res  = $test->request( GET '/api/die');
    ok( $res->is_success, '[GET /api/die] successful' );
    is $res->content, '{"result":"fixed content"}', 'fixed content';
};

