use strict;
use warnings;
use 5.010;

use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common qw(GET POST);

use Cwd qw(abs_path);
use File::Basename qw(dirname);

my $dir = dirname abs_path $0;

my $app = do "$dir/calc.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

my $res  = $test->request( GET '/' );
ok( $res->is_success, '[GET /] successful' );
ok( index( $res->content, '<button id="calc">Calculate</button>') > 0, 'Content looks ok' );


my $calc  = $test->request( POST '/api/calc' , { x => 19, y => 23 });
ok( $calc->is_success, '[POST /api/calc] successful' );
is( $calc->content, '{"result":42}', 'calc 19+23=42' );
