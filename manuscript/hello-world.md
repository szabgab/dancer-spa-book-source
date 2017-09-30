# Hello World

In most programming tutorials printing "Hello World" to the screen is the ultimate first example. Let's pay our duties here as well.

Create the following file:

<<[code/hello_world.psgi](code/hello_world.psgi)

Note I used the extension `psgi`. While it is a Perl program it also adheres to the PSGI standard and while file extensions
don't have any real meaning, having this extension will help remind everyone than instead of running this with `perl` we need
to run this with the special `plackup` command that was installed when we installed Dancer.

Open the terminal window in the directory where you saved the file and run

```
plackup hello_world.psgi
```

It will print something like this:

```
HTTP::Server::PSGI: Accepting connections at http://0:5000/
```

Then you can use your browser to visit the URL printed on the screen. It will redirect to http://0.0.0.0:5000/
and will `Hello World`.

## Troubleshooting {#troubleshooting-used-port}

If, when you try to launch the Dancer application using `plackup` you encounter this error:

```
failed to listen to port 5000: Address already in use at ...
```

that means that there is already another application using port 5000.

There are couple of ways to fix this:

One might be to use a different port by supplying the `-p` option to `plackup`:

```
plackup -p 5001 ...
```

The other option is to find and stop the application that is already using port 5000.

Go over all the open terminal you have an check if there is another `plackup` process running and kill that one using Ctrl-C.

If you can't find any such application then you have stopped an already running application using Ctrl-Z. That means the application
is still using the port, but it currently does not provide service. If you type `jobs` in the terminal that this happen
you will see something like this:

```
[1]+  Stopped                 plackup -r hello_world.psgi
```

You can kill this job by typing `kill %1` or by moving it to the foreground using `fg` and then killing it using `Ctrl-C`.

Lastly what has just happened to me is that I ran a VirtualBox image using Vagrant, but then I tried to run Dancer on my host
operating system. VirtualBox has already used port 5000 and thus I got the above error.

## Explain Hello World

So what is in this Hello World program?

We load `Dancer2` with the standard `use` statement.
You might notice that we don't have a `use strict` nor a `use warnings` statement even though I have been telling everyone they should always use both.
We don't need to load them explicitly here because loading Dancer2 automatically loads and enables these two pragmata.

The next statement is really a strange one. At first it might not be clear what's going on there. The `get` is a function imported by Dancer2.
It receives two parameters '/' and an anonymous subroutine. `=>` the fat arrow is just a replacement of the regular comma `,`.
So we basically have the following code:

```
get('/',  sub { return 'Hello World'; });
```

The last line  in our file is:

```
__PACKAGE__->to_app;
```

`__PACKAGE__` is the name of the current package, but as we have not declared any packages it will just have `main` in it.
We call the `to_app` method on it that was arranged to be a method of Dancer2. It will initiate the application and will return
a code-reference that represents the whole application. When we run `plackup` it loads this file, receives the code-reference as the
return value from loading the file and uses that to launch the web server.


You can check the automatic use strict/use warnings, `get` being a function and __PACKAGE__ being main for yourself by using the [B::Deparse](https://metacpan.org/pod/B::Deparse) module on the hello_world.psgi file:
Run 
```
perl -MO=Deparse hello_world.psgi
```
and you will get:
<<[code/deparsed_hello_world.psgi](code/deparsed_hello_world.psgi)
You can also check what to_app returns by including a print statement `print __PACKAGE__->to_app;` and then running `perl hello_world.psgi`.


## Testing Hello World

Everyone loves to run ahead and develop a full application, but then when they have to make changes they keep wondering if the
change in one corner of the application has any impact on some other area. With small applications such as the "Hello World"
we just wrote you can easily check manually if everything works fine. After all it only answer to a single request.

Anything bigger and the work needed to verify the applications still works properly is exponentially complex and boring.

So people usually don't do it, which means they deploy applications that might be broken in all kinds of ways.

We don't want to do that. That's why we will start writing automated tests from the beginning.

Here is the code that will test our Hello World application.

<<[code/hello_world.t](code/hello_world.t)

So what's in this test code?

It starts off with the fairly standard three `use` statements. Then we load the [FindBin](https://metacpan.org/pod/FindBin) module that provide the
`$FindBin::Bin` variable that holds the path to the directory where the current script is. We need this because
we stored the test file in the same directory where we have the psgi file. 

[Test::More](https://metacpan.org/pod/Test::More) is  the standard testing library of Perl. We load it and we tell it we are going to have 3 tests cases.
3 assertions if you are more familiar with that terminology. 3 calls to the testing functions that the Test::More
module provides. In our case there is one call to the `ok` function and two calls to the `is` function.

[Plack::Test](https://metacpan.org/pod/Plack::Test) provides all kinds of methods that will make it easy to test our Plack-based application.


[HTTP::Request::Common](https://metacpan.org/pod/HTTP::Request::Common) provides methods implementing the HTTP request methods such as GET, POST, HEAD, etc.
We only need the GET method in this test.

TBD

We can execute the test script by running

```
perl hello_world.t
```

The output will look like this:

```
1..3
ok 1 - Got app
ok 2 - [GET /] successful
ok 3 - Content looks ok
```

This output is called TAP or Test Anything Protocol. It is the standard output format of Perl-based tests. It shows one line for each asserting which is good
as long as you have a handful of assertions. If you have more then 10 it starts to get boring and if you have more than the number of lines on your screen then
you can easily miss the one failing among all the successful ones. Therefore a better way to run them is by using the `prove` command that comes with Perl.

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

Which mean everything is OK.

Later we'll see examples of failing test just so you can get used to them.

