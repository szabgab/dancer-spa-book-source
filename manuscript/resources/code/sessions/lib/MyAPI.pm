package MyAPI;
use Dancer2;

set content_type => 'application/json; charset=UTF-8';

post '/code' => sub {
    session(code => 42);
    return encode_json { result => 'set' };
};

get '/code' => sub {
    return encode_json { result => session("code") };
};


1;
