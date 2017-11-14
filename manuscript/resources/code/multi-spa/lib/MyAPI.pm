package MyAPI;
use Dancer2;

set content_type => 'application/json; charset=UTF-8';

get '/hello' => sub {
    #header( 'Content-Type'  => 'application/json; charset=UTF-8' );
    return encode_json { result => 'Hello API' };
};

1;
