package MySite;
use Dancer2;

get '/' => sub {
    return q{
    <input id="code"><button id="set">Set</button>
    <p>
    <button id="get">Get</button>
    <div id="show"></div>


    <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
    $().ready(function() {
       $("#set").click(function () {
          var code = $("#code").val();
          console.log(code);
          $().post("/api/code", { "code" : code }, function() {
              consol.log("set");
          });
       });
       $("#get").click(function () {
       console.log("click get");
});
  //     $("#show").html("hi");
    });
    </script>

    };
};

1;
