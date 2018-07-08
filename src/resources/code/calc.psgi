use Dancer2;

get '/' => sub {
    return q{
        <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
        <script>
        $().ready(function () {
            $('#calc').click(function () {
                console.log("Clicked. Sending " + $('#x').val() + " and " + $('#y').val() );
                $.post( "/api/calc", {
                        x: $('#x').val(),
                        y: $('#y').val()
                    }, function( data ) {
                    console.log( "Response reveived:", data );
                    $( "#result" ).html( data["result"] );
                });
            })
        });
        </script>

        <input id="x">
        <input id="y">
        <button id="calc">Calculate</button>
        <div id="result"></div>
    };
};

post '/api/calc' => sub {
    header( 'Content-Type'  => 'application/json' );
    my $x = body_parameters->{'x'};
    my $y = body_parameters->{'y'};
    return encode_json { result => $x + $y };
};

__PACKAGE__->to_app;
