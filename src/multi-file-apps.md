# Multi file Applications {#multi-file-application}

We could take the single Perl file approach, we used in our ["Hello World"](#hello-world) example further, but even for that case we had an extra file for our tests. A better approach for any application beyond really small ones is to spread the parts of the application in different files. We are going to do that step-by-step.

In our next example we have our application code in a Perl Module with .pm extension. We also have a .psgi file that we only use to load the module and launch the application. In addition we have the test file.

This is the directory layout of our application:

```
.
├── bin
│   └── app.psgi
├── lib
│   └── MySite.pm
└── t
    └── multi.t
```

## The module

The Perl Module that contains our routes looks very similar to what we had in our psgi file in the previous application. We have two routes, one serving the request to `/`, the root of our web site, the other one serving a route called `/other`. Nothing fancy with that. The big difference that you might notice is that we don't call `to_app` in this file. We don't invoke the application. Instead of that we end the file with `1;`. If you are familiar with Perl modules you know that they all must end with a value that is considered `true` by Perl. People usually put `1;` there, though some, who like personal touch might put a quote from a poem. Anyway, this is just a simple Perl module with a few route declarations. We put the Perl file in the `lib` subdirectory as customary in Perl applications.

![code/multi/lib/MySite.pm](code/multi/lib/MySite.pm)

We also have a psgi file that we put in the `bin` subdirectory. This file is responsible for loading the modules that include the application code. In our case we have one module and we use the `use MySite;` to load it. The `use`-statement of Perl will look for the `MySite.pm` file in a set of directories that was defined when Perl itself was installed. This list can be found in the `@INC` variable of Perl, but it does not include our `lib` directory. So if we only wrote `use MySite` we would get an error:

```
Error while loading .../bin/app.psgi: Can't locate MySite.pm in @INC (you may need to install the MySite module) (@INC contains: ...
```

This is a potentially very confusing error message because the reader will start to wonder how to "install the MySite module". We don't need to do that. We can change the list of directories where Perl will look for the MySite.pm file. We can do that in several way. The one I used here was `lib` module to change `@INC` and using the `$Bin` variable of the `FindBin` to locate the path of the "lib" directory relative to the psgi file:

```
use lib "$FindBin::Bin/../lib";
```

## The PSGI script

In addition, in this code we call the `to_app` method on the MySite module name directly.

![code/multi/bin/app.psgi](code/multi/bin/app.psgi)

## The test

The tests are really similar to what had earlier.

![code/multi/t/multi.t](code/multi/t/multi.t)

We can run the tests by opening the terminal in the root directory of the project and then typing `prove`.

We can launch the application by writing `plackup bin/app.psgi`.


