use Dancer2;
 
get '/' => sub {
    return q{
        <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
        <script>
        $().ready(function () {
                $.get( "/api/greeting", function( data ) {
                    console.log( "Response reveived:", data );
                    $( "#result" ).html( data["result"] );
                });
        });
        </script>
        Hello <span id="result"></span> World
    };
};

get '/api/greeting' => sub {
    header( 'Content-Type'  => 'application/json' );
    return encode_json { result => 'Ajax' };
};
  
__PACKAGE__->to_app;

