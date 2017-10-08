package MySite;
use Dancer2;

get '/' => sub {
    return q{
        <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
        <script>
        $().ready(function () {
            $("#calc").click(function() {
                $.post( "/api/calc", {
                        x: $('#x').val(),
                        y: $('#y').val()
                }).done(function( data ) {
                        $( "#result" ).html( data["result"] );
                }).fail(function( event ) {
                    var data = event.responseJSON;
                    $( "#result" ).html( "Error: " + data["result"] );
                });
            });
        });
        </script>
        <h1>Errors</h1>

        <form method="POST" action="/calc">
           <div>HTML divide: <input name="a"> / <input name="b"> <input type="submit" value="="></div>
        </form>

        <div>AJAX divide: <input id="x"> / <input id="y"> <input type="submit" id="calc" value="="> <span id="result"></span></div>
    };
};

post '/calc' => sub {
    my $x = body_parameters->{'a'};
    my $y = body_parameters->{'b'};
    my $result = $x / $y;
    return qq{<a href="/">main</a> $x / $y = $result};
};

package MyAPI;
use Dancer2;
use Scalar::Util qw(looks_like_number);

set content_type => 'application/json; charset=UTF-8';

hook after_error => sub {
    my ($response) = @_;
    debug("after_error");
    $response->header( 'Content-Type'  => 'application/json; charset=UTF-8' ); # TODO has to add manually the global does not work.
    $response->{content} = encode_json { result => 'Internal Error'};
    return;
};
 
get '/static' => sub {
    return encode_json { result => 'fixed content' };
};

post '/calc' => sub {
    my $x = body_parameters->{'x'};
    my $y = body_parameters->{'y'};
    if (not looks_like_number($x)) {
        status 400;
        return encode_json { result => "The value '$x' is not a number" };
    }
    if (not looks_like_number($y)) {
        status 400;
        return encode_json { result => "The value '$y' is not a number" };
    }
    my $result = $x / $y;
    return encode_json { result => $result };
};

package main;
use Plack::Builder;
builder {
    mount '/api'  => MyAPI->to_app;
    mount '/' => MySite->to_app;
};

#__PACKAGE__->to_app;
