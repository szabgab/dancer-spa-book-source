# Hello World

In most programming tutorials printing "Hello World" to the screen is the ultimate first example. Let's pay our duties here as well.

Create the following file:

<<[code/hello_world.pl](code/hello_world.pl)

Then open the terminal window in the directoy where you saved the file and run

```
$ perl hello_world.pl
```

It will print

```
>> Dancer2 v0.205001 server 95368 listening on http://0.0.0.0:3000
```

This means we started the Plack development server that comes with Dancer2.
You can now visit the URL printed to the screen using your regular browser. Firefox, Chrome, or whatever you happen to use.

## With Plack/PSGI

<<[code/hello_world.psgi](code/hello_world.psgi)

```
plackup hello_world.psgi
```

## Testing



<<[code/hello_world.t](code/hello_world.t)

