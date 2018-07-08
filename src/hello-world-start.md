# Hello World using start {#hello-world-start}

This might be a potentially distracting example here, but nevertheless I felt I have to include it somewhere. Even though this is not the path we are going to follow. So feel free to skip this chapter and get back to it only when you are really bored.

Dancer provides a keyword called `start` that can launch a web server good during development or really small in-house applications. Maybe if you'd like to run a web server on your own computer to be accessed only from your computer.

For this we created a file with a .pl extension as we are going to run it with Perl directly. The code is very similar to what we had in the psgi example, but at the end, instead of calling `to_app` in that strange-looking construct we call the `start` function supplied by Dancer2.

![code/hello_world.pl](code/hello_world.pl)

We can run the code directly with Perl:

```
$ perl hello_world.pl
```

It will print

```
>> Dancer2 v0.205001 server 95368 listening on http://0.0.0.0:3000
```

This means we started the Plack development server that comes with Dancer2. You can now visit the URL printed to the screen using your regular browser. Firefox, Chrome, or whatever you happen to use.

