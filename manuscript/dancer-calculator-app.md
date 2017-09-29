# Calculator

<<[code/calc.psgi](code/calc.psgi)

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
[1]+  Stopped                 plackup -r calc.psgi
```

You can kill this job by typing `kill %1` or by moving it to the foreground using `fg` and then killing it using `Ctrl-C`.

Lastly what has just happened to me is that I ran a VirtualBox image using Vagrant, but then I tried to run Dancer on my host
operating system. VirtualBox has already used port 5000 and thus I got the above error.

## Testing

<<[code/calc.t](code/calc.t)

