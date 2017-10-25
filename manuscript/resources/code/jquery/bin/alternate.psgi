use Dancer2;

get '/' => sub {
    return q{
        <!-- Grab jQuery from a CDN, fall back to local if necessary -->
        <script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
        <script type="text/javascript">/* <![CDATA[ */
            !window.jQuery && document.write('<script type="text/javascript" src="/jquery-2.1.4.min.js"><\/script>')
        /* ]]> */</script>
        
        <script>
        $().ready(function() {
            $("#text").html("hi "+ Date());
        });
        </script>

        <div id="text"></div>
    };
};

__PACKAGE__->to_app;
