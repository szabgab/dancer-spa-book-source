$().ready(function () {
    $("#calc").click(function() {
        $.post( "/api/calc", {
                x: $('#x').val(),
                y: $('#y').val()
        }).done(function( data ) {
                $( "#result" ).html( data["result"] );
        }).fail(function( event ) {
            var data = event.responseJSON;
            $( "#result" ).html( "Error: " + data["result"] );
        });
    });
});
