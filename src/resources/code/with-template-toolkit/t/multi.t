use strict;
use warnings;
use 5.010;

use Test::More tests => 3;
use Plack::Test;
use HTTP::Request::Common qw(GET);
use FindBin;

my $app = do "$FindBin::Bin/../bin/app.psgi";
is( ref $app, 'CODE', 'Got app' );
my $test = Plack::Test->create($app);

subtest main => sub {
    plan tests => 5;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    is( $res->header('Content-type'), 'text/html; charset=UTF-8' );
    like( $res->content, qr{<html>}, 'html found' );
    like( $res->content, qr{<h1>Hello World</h1>}, 'h1 found' );
    like( $res->content, qr{<a href="/other">Other page</a>}, 'link found' );
};

subtest other => sub {
    plan tests => 14;

    my $res  = $test->request( GET '/other' );
    ok( $res->is_success, '[GET /other] successful' );
    is( $res->header('Content-type'), 'text/html; charset=UTF-8' );
    like( $res->content, qr{<html>}, 'html found' );
    like( $res->content, qr{<h1>Other World</h1>}, 'h1 found' );
    like( $res->content, qr{<a href="/">Home</a>}, 'link found' );
    like( $res->content, qr{<a href="/">Home</a>}, 'link found' );
    like( $res->content, qr{<div id="name">Foo Bar</div>}, 'name' );

    like( $res->content, qr{<li>Perl</li>}, 'languages' );
    like( $res->content, qr{<li>JavaScript</li>}, 'languages' );
    like( $res->content, qr{<li>English</li>}, 'languages' );

    like( $res->content, qr{<div>We have a true condition.</div>}, 'condition' );
    unlike( $res->content, qr{<div>no condition</div>}, 'condition' );
    like( $res->content, qr{<div>other_condition is false</div>}, 'condition' );
    unlike( $res->content, qr{<div>We have another ture condition.</div>}, 'condition' );

};
