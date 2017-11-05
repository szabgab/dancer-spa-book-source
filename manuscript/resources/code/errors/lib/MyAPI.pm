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

1;

