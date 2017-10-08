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
    plan tests => 2;

    my $res  = $test->request( GET '/' );
    ok( $res->is_success, '[GET /] successful' );
    is( $res->content, 'Hello World <a href="/api/hello">API</a>', 'Content looks ok' );
};

subtest api => sub {
    plan tests => 2;

    my $res  = $test->request( GET '/api/hello' );
    ok( $res->is_success, '[POST /api/hello] successful' );
    is $res->content, '{"result":"Hello API"}', 'API'
};

