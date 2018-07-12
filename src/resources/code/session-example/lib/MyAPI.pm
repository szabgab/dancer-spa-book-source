package MyAPI;
use Dancer2;

set content_type => 'application/json; charset=UTF-8';

post '/code' => sub {
    my $code = body_parameters->{'code'};
    if (defined $code) {
        session(code => $code);
        return encode_json { result => 'set' };
    } else {
        status 400;
        return encode_json { error => 'No code provided' };
    }
};

get '/code' => sub {
    my $code = session("code");
    return encode_json { result => $code };
};

1;
