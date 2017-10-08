use Dancer2;

hook after_error => sub {
    my ($response) = @_;
    debug($response->header('Content-Type')); # unfortunately it does not seem to be set at this point
    if ($response->header('Content-Type') eq 'application/json' ) {
        $response->{content} = encode_json {result => 'Internal error'}
    }
    return;
};
 
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

get '/api/static' => sub {
    header( 'Content-Type'  => 'application/json' );
    return encode_json { result => 'fixed content' };
};

get '/api/die' => sub {
    header( 'Content-Type'  => 'application/json' );
    die "Oups. An exception";
    return encode_json { result => 'exceptional JSON content' };
};

get '/die' => sub {
    die "Oups. An exception";
    return 'exceptional HTML content';
};
    
__PACKAGE__->to_app;
