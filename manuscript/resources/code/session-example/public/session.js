$().ready(function() {

    $("#set").click(function () {
        var code = $("#code").val();
        console.log(code);
        $.post("/api/code", { "code" : code }, function() {
            console.log("set");
        });
    });

    $("#get").click(function () {
        console.log("click get");
        $.get("/api/code", function(data) {
            console.log("get responed", data);
            $("#show").html(data["result"]);
        });
    });
});

