# Hello World - Single Page Application

In the previous chapter we created our very first Dancer application that returned an HTML page. In this chapter we are going to create our very first Single Page Application. It will be just as simple as the previous application, but instead of returning the full HTML page we will return just the skeleton of the page, then we will send an Ajax request to the server for the data and will fill the missing field with the data we get from the server.


{aside}
## What is AJAX?  {#ajax}

AJAX stands for Asynchronous JavaScript and XML and even though the last letter refers to XML, in most cases today what is sent back-and-forth on the wire is JSON instead of XML. Asynchronous means that when the JavaScript code running in the browser sends a request to the server it does not wait for an answer. Instead it keeps running and keeps serving the user. If it was waiting for an answer the browser would seem to be "stuck" till we get an answer. This would be quite unpleasant. So instead, before we send the asynchronous request we also provide a function, we usually call "callback function" that will be executed when the browser received the response.

Basically the browser has a loop running in it that executes pieces of JavaScript code and checks for various events. For example events when the user clicks on a button or just hovers the mouse over an item, or when some data arrives in response to an earlier Asynchronous call.  For some of these event these events the browser has some built-in function to execute. For example when you hover the mouse over an image, when the browser notices, it will execute a piece of built-in code that will take the "title" field from the img attribute in the HTML, and show a little popup with that text. For other events there is no build-in callback. For most events you can replace the built-in event with your own callback function. So when we send the AJAX request we also add a callback function and when the browser has time and checks for new events that have arrived it will see the event that data has returned in response to your request and will call the callback function you provided earlier. It will also pass the data it received to the function.
{/aside}

## The code

![code/hello_world_spa.psgi](code/hello_world_spa.psgi)

In this application you can see two routes. The first one maps the '/' URL to an anonymous function that returns a very simple HTML page with some JavaScript code embedded in it. The second route maps the '/api/greeting' URL to another anonymous function that return a JSON string. This is the API we provide for this web site.

Probably I should put it in quotes writing "API" as this is a rather slim API having only a single endpoint returning the same string to everyone. Nevertheless it is the beginning of a great API.

When a normal user visits this site she will access the '/' URL and will receive the HTML and the embedded JavaScript. The HTML is really simple it only contains:

{line-numbers=off, lang=html}
```
Hello <span id="result"></span> World
```

The `<span id="result"></span>` is an empty HTML tag that is displayed "inline". That mean there is not line-break between the "Hello" and the "World". If you use a browser in which JavaScript is disabled, or if you load this page while you don't have external Internet access, the only thing you will see in your browser is "Hello World".

If JavaScript is enabled then the `<script>` tags will be executed. The first script tag loads the jQuery library from the jQuery web site. If we don't have Internet connection this will fail.

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

`$.get` is another jQuery expression that sends an asynchronous GET request to the URL provided as the first parameter, in our case to `/api/greeting` on the same server where
the page came from. The second parameter is another anonymous function, the callback function,  that will be called when the response arrives. This callback function expects
a variable called data that will be filled by the data returned from the server. The function does two things.

The first is to print the received data to the console of the browser. We do this only for debugging purposes and to make it easy to see what have we received from the server.
In the second line we locate the HTML element that has an ID called "result" and in that element we inject the value received from the server.
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

## Testing Hello World SPA

Just as for the plain HTML "Hello World", here too we would like to write a test so we can make sure that even after
we make changes to the application, features that worked earlier keep working.

![code/hello_world_spa.t](code/hello_world_spa.t)
# Hello World

In most programming tutorials printing "Hello World" to the screen is the ultimate first example. Let's pay our duties here as well.

## The code

Create the following file:

![code/hello_world.psgi](code/hello_world.psgi)

Note, I used the extension `psgi`. File extensions don't have a lot of impact. Especially on Linux. You can use any extension with any content, but some tools use the file extension as a hint to recognize the type of the content. For example editors usually map file extensions to languages that means appropriate syntax coloring.

This is a Perl program, but it also adheres to the PSGI standard. Having psgi extension will help remind everyone that instead of running this with `perl` we need something else to run this. For example during development we use the special `plackup` command that was installed when we installed Dancer.

Open the terminal window in the directory where you saved the file and run

{line-numbers=off}
```
plackup hello_world.psgi
```

It will print something like this:

{line-numbers=off, lang=text}
```
HTTP::Server::PSGI: Accepting connections at http://0:5000/
```

Then you can use your browser to visit the URL printed on the screen. It will redirect to http://0.0.0.0:5000/ and it will show `Hello World`.

## Troubleshooting used port {#troubleshooting-used-port}

When you try to launch the Dancer application using `plackup`, if you encounter this error:

{line-numbers=off, lang=text}
```
failed to listen to port 5000: Address already in use at ...
```

that means that there is already another application using port 5000.

There are couple of ways to fix this:

One might be to use a different port by supplying the `-p` option to `plackup`:

{line-numbers=off, lang=text}
```
plackup -p 5001 ...
```

The other option is to find and stop the application that is already using port 5000.

Go over all the open terminal you have an check if there is another `plackup` process running and kill that one using Ctrl-C.

If you can't find any such application then you might have stopped an already running application using Ctrl-Z. That means the application is still using the port, but it currently does not provide service. If you type `jobs` in the terminal that this happened
you will see something like this:

{line-numbers=off, lang=text}
```
[1]+  Stopped                 plackup -r hello_world.psgi
```

You can kill this job by typing `kill %1` or by moving it to the foreground using `fg` and then killing it using `Ctrl-C`.

Lastly what has just happened to me is that I ran a VirtualBox image using Vagrant, but then I tried to run Dancer on my host operating system. VirtualBox has already used port 5000 and thus I got the above error. As I wanted to test the code on the host system, I just set a different port using the `-p` option.

## Explain Hello World

So what is in this Hello World program?

We load `Dancer2` with the standard `use` statement.

```
use Dancer2;
```

You might notice that we don't have a `use strict` nor a `use warnings` statement even though I have been telling everyone they should always use both.  We don't need to load them explicitly here because Dancer2 automatically loads and enables these two pragmas.

The next statement is really a strange one.

```
get '/' => sub {
    return 'Hello World';
};
```

At first it might not be clear what's going on there, but if you look closer you might see that the `get` is a function imported by Dancer2. It receives two parameters '/' and an anonymous subroutine. `=>` the fat arrow is just a replacement of the regular comma `,`. So we basically have the following code:

```
get('/',  sub { return 'Hello World'; });
```

It maps a URL to an anonymous function. When a user visits the URL the first parameter matches, in this case when the user visits the root of the web site, then the function passed as the second parameter will be called. Whatever this second function returns that will be the content returned to the user. In our very simple case this is just the string 'Hello World'.

The last line  in our file is:

```
__PACKAGE__->to_app;
```

`__PACKAGE__` is the name of the current package, but as we have not declared any packages it will just have `main` in it.
(We will discuss other packages later on.) We call the `to_app` method on it that was arranged to be a method of Dancer2. It will initiate the application and will return a code-reference that represents the whole application. When we run `plackup` it loads this file, receives the code-reference as the return value from loading the file and uses that to launch the web server.


You can check the automatic use strict/use warnings; `get` being a function; and `__PACKAGE__` being `main` for yourself by using the [B::Deparse](https://metacpan.org/pod/B::Deparse) module on the hello_world.psgi file: Run 

```
perl -MO=Deparse hello_world.psgi
```

and you will get:

![code/deparsed_hello_world.psgi](code/deparsed_hello_world.psgi)

You can also check what to_app returns by including a print statement in the last line:

```
print __PACKAGE__->to_app;
```

and then running `perl hello_world.psgi`.

It won't launch the web server, but it will print something like this:

```
CODE(0x7faac92ac1b8)
```


## Testing Hello World

Everyone loves to run ahead and develop a full application, but then when they have to make changes they keep wondering if the change in one corner of the application has any impact on some other area. With small applications such as the "Hello World" we just wrote you can easily check manually if everything works fine. After all it only answers to a single request.

Anything bigger and the work needed to verify the applications still works properly is exponentially more complex and boring. One of the services I provide my clients is help them start writing automated tests. It is very frustrating to see people in the QA department who have to check every potential release of the software for functionality that could be checked automatically.

So people usually don't do it. They usually only check the new features or the bugs that were fixed and maybe one or two critical functionality of the system. Which means they deploy applications that might be broken in all kinds of ways.

We don't want to do that. That's why we will start writing automated tests from the beginning.

### Test code

Here is the code that will test our Hello World application.

![code/hello_world.t](code/hello_world.t)

So what's in this test code?

It starts off with the fairly standard three `use` statements. Then we load the [FindBin](https://metacpan.org/pod/FindBin) module that provide the `$FindBin::Bin` variable that holds the path to the directory where the current script is. We need this because
we stored the test file in the same directory where we have the psgi file and in just a few lines we will load that file.

[Test::More](https://metacpan.org/pod/Test::More) is  the standard testing library of Perl. We load it and we tell it we are going to have 3 test cases. Also called 3 assertions if you are more familiar with that terminology. These are 3 calls to the testing functions provided by the Test::More module. In our case there is one call to the `ok` function and two calls to the `is` function.

[Plack::Test](https://metacpan.org/pod/Plack::Test) provides all kinds of methods that will make it easy to test our Plack-based application.


[HTTP::Request::Common](https://metacpan.org/pod/HTTP::Request::Common) provides methods implementing the HTTP request methods such as GET, POST, HEAD, etc. We only need the GET method in this test.

The next line uses the `do` [Perl statement](https://metacpan.org/pod/distribution/perl/pod/perlfunc.pod#do-BLOCK) to load and execute the content of the psgi file. Whatever is the result of the last statement in the psgi file will be the return value of the `do` statement. As we have just seen the last statement returns a CODE-reference representing the application. That code-reference will be assigned to `$app`.

{line-numbers=off}
```
my $app = do "$FindBin::Bin/hello_world.psgi";
```

In the next line we use the `is` functions provided by Test::More. It compares whether the first two parameters are equal using the `eq` operator and uses the (optional) 3rd parameter as the description of this assertion. The first parameter is the actual result. The second is the expected value. We basically check if the psgi file returned a CODE-reference through
the `do` statement.

{line-numbers=off}
```
is( ref $app, 'CODE', 'Got app' );
```

Once we checked that the returned values is indeed a CODE-reference we can use it to create a Plack::Test instance. Instead of launching the application that will listen on a certain port and then accessing it with a web client in a separate process, we can use the Plack::Test to imitate the whole web server.

{line-numbers=off}
```
my $test = Plack::Test->create($app);
```

Then we can use the object to send a GET request to the '/' URL on this not-really-running web server. It returns and object representing the response received from the server.

{line-numbers=off}
```
my $res  = $test->request( GET '/' );
```

We can then interrogate the response object in various ways to see if the response was as we expected. In the first line we check if the response was successful. This is basically checking if the server (the fake server) return the '200 OK' HTTP response code. `is_success` already returns some True or False value so we don't need `is` to compare it to anything. We use the `ok` function provided by Test::More that receives 2 arguments. The first one is checked for its boolean value. If it evaluates to True then the test cases passes, if it evaluates to false then the test case fails. The second parameter is just the description of this assertion. Some plain text string.

{line-numbers=off}
```
ok( $res->is_success, '[GET /] successful' );
```

In the second line we use the `content` method to return the content that the browser would receive if this was a real web server. This should be the same that was returned by our route.

{line-numbers=off}
```
is( $res->content, 'Hello World', 'Content looks ok' );
```

The Hello World application is a trivial application and so the tests are also trivial. However this illustrates well how to write basic tests and this will be a useful base to build upon as we make progress with our application.

### Test running

We can execute the test script by running

{line-numbers=off, lang=text}
```
perl hello_world.t
```

The output will look like this:

{line-numbers=off}
```
1..3
ok 1 - Got app
ok 2 - [GET /] successful
ok 3 - Content looks ok
```

This output is called [TAP or Test Anything Protocol](https://perlmaven.com/tap-test-anything-protocol). It is the standard output format of Perl-based tests. It shows one line for each assertion which is good as long as you have a handful of assertions. If you have more than 10 it starts to get boring and if you have more than the number of lines on your screen then you can easily miss the one failing among all the successful ones. Therefore a better way to run them is by using the `prove` command that comes with Perl.

```
prove hello_world.t
```

Will print the following:

```
hello_world.t .. ok
All tests successful.
Files=1, Tests=3,  1 wallclock secs ( 0.04 usr  0.02 sys +  0.57 cusr  0.06 csys =  0.69 CPU)
Result: PASS
```

Which means everything is OK.

Later we'll see examples of failing tests just so you can get used to them.

## Exercise Hello World {#exercise-hello-world}

Create a Dancer-based application in a single file that has two routes: '/' returns a pages that says "Hello World" in it and has a link `<a href="/about">About</a>`. '/about' returns a text that has displays your name and a link back to the main page `<a href="/">main</a>`.

Extra points if you also write the tests for it.

Check the [solutions](#solutions)


The first few lines are the same as with our previous test, except that we plan for 5 test-cases.

The first difference is when we check the content returned by the main page of the application. Previously we used the `is` function provided by Test::More to check for exact matching. That worked well in our overly simplicistic case, but won't work in real life situation. Even in our second example, testing for an exact match is already problematic. The majority of the content is JavaScript. We might be interested in the outcome executing this JavaScript code, but we are certainly not interested in the exact layout of this code. In the more generic case when you check if a page contains all the necessary data, you do exactly that. Check if it contains.
You don't check exact matching.

So here too we replaced the exact matching with a piece of code that checks if a certain HTML snippet can be found in the response. For this we use the `index` function of Perl that will return the location of the second string in the first string or will return -1 if the second string cannot be found in the first one. We have a boolean operation as the first parameter of the `ok` function and thus the first parameter `ok` will receive will be either True or False. So in our test-case we'll check if the return value of the `index` funciton is greater than 0.
 
{line-numbers=off}
```
ok( index($res->content, 'Hello <span id="result"></span> World') >= 0, 'Content looks ok' );
```

Then we have 3 additional lines testing the response of the API call to `/api/greeting`.

First we send a `GET` request to the web application and store the response in a variable we called `$ajax`.

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

In this case we could check that the JSON string matches exactly as it has only one key and one value. In the general case a JSON might represent a hash with multiple keys and values. As the keys of hashes are not ordered the representation of that hash in JSON is not ordered either. Each GET request can return the keys in a different order. If we would like to test the response in those cases we will either have to ensure the order of keys in the response we generate on the server or we need to find a way to disregard those differences.

For example by converting the JSON structure into a Perl hash and comparing that to an expected hash.

