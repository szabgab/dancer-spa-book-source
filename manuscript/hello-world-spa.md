# Hello World - Single Page Application

In the previous chapter we created our very first Dancer application that returned an HTML page. In this chapter we are going to create our very first Single Page Application.
It will be just as simple as the previous application, but instead of returning the full HTML page we will return just the skeleton of the page, then we will send an Ajax request to the
server for the data and will fill the missing field with the data we get from the server.

A> What is AJAX?
A> AJAX stands for Asynchronous JavaScript and XML and even thouh the last letter refers to XML, in most cases today what is sent back-and-forth on the wire
A> is JSON instead of XML.
A> Asyncrhonous means that when the JavaScript code running in the browser sends a request to the server it does not wait for an answer. Instead it keeps running
A> and keeps serving the user. If it was waiting for an answer the browser would seem to be "stuck" till we get an answer. This would be quite unpleasant.
A> So instead, before we send the asynchronous request we also provide a function, we usually call "callback function" that will be executed when the browser
A> received the respons.
A> Basically the browser has loop running in it that executes pieces of JavaScript code and checks for various events. For example events when the user clicks on
A> a button or just hovers the mouse over an item, or when some data arrives in response to an earlier Asynchronous call.
A> For some of these event these events the browser has some built-in function to execute. For example when you hover the mouse over an image, when the browser
A> notices, it will execute a piece of built-in code that will take the "title" field from the img attribute in the HTML, and show a little popup with that text.
A> For other events there is no build-in callback.
A> For most events you can replace the built-in event with your own callback function.
A> So when we send the AJAX request we also add a callback function and when the browser has time and checks for new events that have arrived it will see the event
A> that data has returned in response to your request and will call the callback function you provided earlier. It will also pass the data it received to the function.


<<[code/hello_world_spa.psgi](code/hello_world_spa.psgi)

In this application you can see two routes. The first one maps the '/' URL to an anonymous function that returns a very simple HTML page with some JavaScript code
embedded in it. The second route maps the '/api/greeting' URL to another anonymous function that return a JSON string. This is the API we provide for this web site.

Probably I should put it in quotes writing "API" as this is a rather slim API having only a single endpoint returning the same string to everyone. Nevertheless it is
the beginnig of a great API.

When a normal user visits this site she will access the '/' URL and will receive the HTML and the embedded JavaScript. The HTML is really simple it only contains:

{line-numbers=off, lang=html}
```
Hello <span id="result"></span> World
```

The `<span id="result"></span>` is an empty HTML tag that is displayed "inline". That mean there is not line-break between the "Hello" and the "World". If you use a browser
in which JavaScript is disabled, or if you load this page while you don't have external Internet access, the only thing you will see in your browser is "Hello World".

If JavaScript is enabled then the `<script>` tags will be executed. The first script tag loads the jQuery library from the jQuery web site. If we don't have Internet connection
this will fail.

{line-numbers=off, lang=html}
```
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
```

The second `<script>` tag is where the real code can be found.


{line-numbers=off, lang=javascript}
```
$().ready(function () {
        $.get( "/api/greeting", function( data ) {
            console.log( "Response reveived:", data );
            $( "#result" ).html( data["result"] );
        });
});
```

The `$().ready()` is a jQuery code-snippet. It says that once the HTML page is loaded and rendered in the browser execute the function passed to this call.

Inside we can find an anonymous function declared with the `function` keyword. It does not expect any parameters, hence the `()` after the word `function`.

`$.get` is another jQuery exression that sends an asynchronous GET request to the URL provided as the first parameter, in our case to `/api/greeting` on the same server where
the page came from. The second parameter is another anonymous function, the callback function,  that will be called when the response arrives. This callback function expects
a variable called data that will be filled by the data returned from the server. The function does two things.

The first is to print the received data to the console of the browser. We do this only for debugging purposes and to make it easy to see what have we received from the server.
In the second line we locate the HTML element that has an ID called "result" and in that element we inject the value recived from the server.
In this line we already use "data" as a JavaScript object.

This can be done due to another helper feature of jQuery. The "data" passed to the function is the raw string as we received from the server only if we don't get instructions from the server how to treat this data. If the server sets the Content-Type of its response to `application/json` then jQuery assumes the returned string is a JSON string and converts it to real JavaScript object before passing it to the callback function.

The end result is that when you visit the page with a browser that has JavaScript enabled, you will see "Hello Ajax World".


When the user loads the main pages of this site, the JavaScript (jQuery) code starts running. It sends a GET request in the background to the `/api/greeting` address that sets the Content-Type
to `application/json` and sends the json string created from the `{ result => 'Ajax' }` hash reference. The `encode_json` function is provided by Dancer.

We can see what the API request returns if we turn our browser to http://127.0.0.1:5000/api/greeting or if we run

{line-numbers=off, lang=text}
```
curl http://127.0.0.1:5000/api/greeting
```

{line-numbers=off, lang=json}
```
{"result":"Ajax"}
```

We can also see the header if we run

{line-numbers=off, lang=text}
```
curl -I http://127.0.0.1:5000/api/greeting
```

The output will look like this:

{line-numbers=off, lang=text}
```
HTTP/1.0 200 OK
Date: Sun, 01 Oct 2017 07:58:15 GMT
Server: HTTP::Server::PSGI
Server: Perl Dancer2 0.205001
Content-Length: 17
Content-Type: application/json
```

Lastly, if you'd like to see both the content and the header for the same request then you can use the following parameters with `curl`:

{line-numbers=off, lang=text}
```
curl http://127.0.0.1:5000/api/greeting -D header.txt
```

This will print the content of the response to the terminal and the header will be saved (dumped) in the `header.txt` file.

## Testing

Just as for the plain HTML "Hello World", here too we would like to write a test so we can make sure that even after
we make changes to the application, features that worked earlier keep working.

<<[code/hello_world_spa.t](code/hello_world_spa.t)

The first few lines are the same as with our previous test, except that we plan for 5 test-cases.

The first difference is when we check the content returned by the main page of the application.
Previously we used the `is` function provided by Test::More to check for exact matching. That worked well
in our overly simplicistic case, but won't work in real life situation. Even in our second example,
testing for an exact match is already problematic. The majority of the content is JavaScript. We might be interested
in the outcome executing this JavaScript code, but we are certainly not interested in the exact layout of this code.
In the more generic case when you check if a page contains all the necessary data, you do exactly that. Check if it contains.
You don't check exact matchin.

So here too we replaced the exact matching with a piece of code that checks if a certain HTML snippet can be found in the response.
For this we use the `index` function of Perl that will return the location of the second string in the first string or will return
-1 if the second string cannot be found in the first one. We have a boolean operation as the first parameter of the `ok` function
and thus the first parameter `ok` will receive will be either True or False.
 
{line-numbers=off}
```
ok( index($res->content, 'Hello <span id="result"></span> World') >= 0, 'Content looks ok' );
```

Then we have 3 additional lines testing the response of the API call to `/api/greeting`.

First we send a `GET` request to the web application and store the response in a varibale we called `$ajax`.

{line-numbers=off}
```
my $ajax  = $test->request( GET '/api/greeting' );
```

Then we check if the response was "200 OK":

{line-numbers=off}
```
ok( $ajax->is_success, '[GET /api/greeting] successful' );
```

Finally we check if the response contains the exact JSON string we expect.

{line-numbers=off}
```
is( $ajax->content, '{"result":"Ajax"}', 'Content looks ok' );
```

In this case we could check that the JSON string matches exactly as it has only one key and one value.
In the general case a JSON might represent a hash with multiple keys and values. As the keys of hashes
are not ordered the representation of that hash in JSON is not ordered either. Each GET request can
return the keys in a different order. If we would like to test the response in those cases we will either have to ensure the
order of keys in the response we generate on the server or we need to find a way to disregard those differences.

For example by converting the JSON structure into a Perl hash and comparing that to an expected HASH.

