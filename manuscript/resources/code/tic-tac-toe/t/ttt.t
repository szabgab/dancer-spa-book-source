use strict;
use warnings;
use 5.010;

use Test::More tests => 2;
use Plack::Test;
use HTTP::Request::Common qw(GET);
use FindBin;

my $app = do "$FindBin::Bin/../bin/app.psgi";
is( ref $app, 'CODE', 'Got app' );
my $test = Plack::Test->create($app);

subtest main => sub {
    plan tests => 4;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    is( $res->header('Content-type'), 'text/html; charset=UTF-8' );
    like( $res->content, qr{<html>}, 'html found' );
    like( $res->content, qr{<h1>Tic Tac Toe</h1>}, 'h1 found' );
};

