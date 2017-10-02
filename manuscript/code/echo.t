use strict;
use warnings;
use 5.010;

use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common;

use Cwd qw(abs_path);
use File::Basename qw(dirname);

my $dir = dirname abs_path $0;

my $app = do "$dir/echo.psgi";
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

my $res  = $test->request( GET '/' );
ok( $res->is_success, '[GET /] successful' );
ok( index( $res->content, '<button id="echo">Echo</button>') > 0, 'Content looks ok' );


my $echo  = $test->request( POST '/api/echo' , { txt => 'abc' });
ok( $echo->is_success, '[POST /api/echo] successful' );
is $echo->content, '{"result":"cba"}', 'echo abc=cba';
