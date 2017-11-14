# Hello World {#hello-world}

In most programming tutorials printing "Hello World" to the screen is the ultimate first example. Let's pay our duties here as well.

## The code

Create the following file:

{line-numbers=on, lang=perl}
![code/hello_world.psgi](code/hello_world.psgi)

Note, I used the extension `psgi`. File extensions don't have a lot of impact. Especially on Linux. You can use any extension with any content, but some tools use the file extension as a hint to recognize the type of the content. For example editors usually map file extensions to languages that means appropriate syntax coloring.

This is a Perl program, but it also adheres to the PSGI standard. Having psgi extension will help remind everyone that instead of running this with `perl` we need something else.  For example during development we will run this with the special `plackup` command that was installed when we installed Dancer.

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

You might notice that we don't have a `use strict` nor a `use warnings` statement even though I have been telling everyone they should always use both. We don't need to load them explicitly here because Dancer2 automatically loads and enables these two pragmas.

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

