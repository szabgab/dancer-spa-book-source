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
                        op: $('#op').val(),
                        y: $('#y').val()
                    }, function( data ) {
                    console.log( "Response reveived:", data );
                    $( "#result" ).html( data["result"] );
                });
            })
        });
        </script>
        
        <input id="x">
        <input id="op">
        <input id="y">
        <button id="calc">Calculate</button>
        <div id="result"></div>
    };
};

post '/api/calc' => sub {
    header( 'Content-Type'  => 'application/json' );
    my $x = body_parameters->{'x'};
    my $op = body_parameters->{'op'};
    my $y = body_parameters->{'y'};
    my $result;
    if ($op eq '+') {
        $result = $x + $y;
    } elsif ($op eq '-') {
        $result = $x - $y;
    } elsif ($op eq '*') {
        $result = $x * $y;
    } elsif ($op eq '/') {
        $result = $x / $y;
    } else {
        $result = "Invalid operator '$op'";
    }
    return encode_json { result => $result };
};
  
__PACKAGE__->to_app;

