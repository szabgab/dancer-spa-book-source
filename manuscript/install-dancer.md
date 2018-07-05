## Install Dancer {#install-dancer}

Dancer, or more specifically Dancer2 is a Perl module distributed via [CPAN, the Comprehensive Perl Archive Network](https://www.cpan.org/). There are many ways to install a Perl module depending on your operating system and your preferences.

### Linux - from the distribution

Many Linux distributions such as Ubuntu package Dancer2 and allow you to install it using the standard package management system. For example on Ubuntu you could install it using the following command:

```
$ sudo apt-get install libdancer2-perl
```

For this you need to have `root`, or more precisely `sudo` rights. This is a very easy way to install Dancer. It also has the advantage that using the exact same Linux distribution on multiple servers will bring you the exact same version of Dancer everywhere.

The big drawback is that we are using a rather old version of Dancer and some additional Perl modules that we might want to use will not be available with this method. For those methods we'll have to use one of the CPAN clients to install the module.

TBD


### Installing Dancer with cpanm

Once you have Perl and cpanm installed we can start installing the Perl Modules we need

```
cpanm Dancer2
```

it will take a long time and it will install the latest edition of Dancer2 and pull in all the modules required by Dancer2. When I ran it, it installed 105 distributions from CPAN.

Using this command is great if you'd like to get the latest and greatest of all these modules, however this carries some risks. If you run the same command later you will potentially receive different versions of Dancer2 and the dependencies. This command always installs the latest version of any missing module, but it won't upgrade any of the dependencies if they already have an installed version that satisfies the requirements.

In most cases these differences won't have an impact on your application, but having different versions carries some risk with it. Setting a minimum required version of Dancer2 and of other modules you use will reduce the risk by a lot. A better solution is to set the specific version of each one of the modules you require. There are several ways to do that. For example [Carton](https://metacpan.org/pod/Carton).  Using it is beyond the scope of this book.

In any case, it is usually a good idea to have latest version of Dancer2 and other modules. They tend to be better (faster, smarter, more secure, less memory leaks, etc.). In order to make it safe to upgrade the modules you use, it is a good idea to have a comprehensive test suite for your application.

We'll need a few additional modules. Better install them now:

```
cpanm Plack::Middleware::Deflater
```

