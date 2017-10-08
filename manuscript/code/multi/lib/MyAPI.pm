package MyAPI;
use Dancer2;

get '/hello' => sub {
    header( 'Content-Type'  => 'application/json' );
    return encode_json { result => 'Hello API' };
};

1;
