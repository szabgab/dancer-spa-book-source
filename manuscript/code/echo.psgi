use Dancer2;
 
get '/' => sub {
    return q{
        <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
        <script>
        $().ready(function () {
            $('#echo').click(function () {
                console.log("Clicked. Sending " + $('#txt').val());
                $.post( "/api/echo", {
                        txt: $('#txt').val(),
                    }, function( data ) {
                    console.log( "Response reveived:", data );
                    $( "#result" ).html( data["result"] );
                });
            })
        });
        </script>
        
        <input id="txt">
        <button id="echo">Echo</button>
        <div id="result"></div>
    };
};

post '/api/echo' => sub {
    header( 'Content-Type'  => 'application/json' );
    my $txt = body_parameters->{'txt'};
    return encode_json { result => scalar reverse $txt };
};
  
__PACKAGE__->to_app;
