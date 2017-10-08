package MySite;
use Dancer2;

get '/' => sub {
    return q{
        <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
        <script>
        $().ready(function () {
        });
        </script>
        <h1>Errors</h1>
    };
};

get '/die' => sub {
    die "Oups. An exception";
    return 'exceptional HTML content';
};

package MyAPI;
use Dancer2;

set content_type => 'application/json; charset=UTF-8';

hook after_error => sub {
    my ($response) = @_;
    $response->{content} = encode_json {result => 'Internal Error'};
    $response->header( 'Content-Type'  => 'application/json; charset=UTF-8' ); # TODO has to add manually the global does not work.
    return;
};
 
get '/static' => sub {
    return encode_json { result => 'fixed content' };
};

get '/die' => sub {
    die "Oups. An exception";
    return encode_json { result => 'exceptional JSON content' };
};

package main;
use Plack::Builder;
builder {
    mount '/api'  => MyAPI->to_app;
    mount '/' => MySite->to_app;
};

#__PACKAGE__->to_app;
