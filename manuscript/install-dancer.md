# Install Dancer {#install-dancer}

Dancer, or more specifically Dancer2 is a Perl module distributed via [CPAN, the Comprehensive Perl Archive Network](https://www.cpan.org/).
There are many ways to install a Perl module depending on your operating system and your preferences.

## Linux - compile Perl and use cpanminus

CPAN has [the instructions](https://www.cpan.org/src/README.html) how to download the source of Perl and how to compile and install it,
but let me repeate them here:

```
sudo apt-get install -y make gcc
```

```
wget http://www.cpan.org/src/5.0/perl-5.26.1.tar.gz
tar -xzf perl-5.26.1.tar.gz
cd perl-5.26.1
./Configure -des -Dprefix=$HOME/perl-5261
make
make test
make install
```

This will install perl in the perl-5261 directory in your home directory.

For more convenience you'd probably want to change the `PATH` environment variable to include the directory of this new perl before all the other directories.

Put the following line in the ~/.bashrc file towards the end.

```
export PATH=$HOME/perl-5261/bin:$PATH
```

and then reload the file using `source ~/.bashrc`.

Once you have done this you can verify that this part worked properly.

```
$ which perl
```

will show you the location of the perl executable that will be the default one. In my case it showed

```
/home/ubuntu/perl-5261/bin/perl
```

I could also check the version of Perl using

```
$ perl -v
```

It is 

```
This is perl 5, version 26, subversion 1 (v5.26.1) built for x86_64-linux
```



Installing the requitred modules using [cpanminus](http://cpanmin.us/).
Don't get to worried if you visit the website of cpan minus. The only thing you'll find there is the
compressed version of the installation script.
The recommended way to download and install cpanminus is to run

```
$ curl -L https://cpanmin.us | perl - App::cpanminus
```

but that might not work for you. In any case you could split that command in two:

```
$ wget  https://cpanmin.us/
$ perl index.html App::cpanminus
```

The `wget` command will save the main page of the cpanmin.us website as `index.html`. Although it is saved as if it was an HTML file
in fact it is Perl script we saw on that page. We could rename the file to make it look more like a Perl script, but we don't need to.
We can run it as it is. The second command executes the content of the index.html file with the current perl and passes 'App::cpanminus'
as argument.

This will install the latest edition of CPAN Minus, the popular CPAN client.
You can verify that the installation was successful by typing

```
$ which cpanm
```

and observing that it found the command in the expected place. In my case it printed:

```
/home/ubuntu/perl-5261/bin/cpanm
```

## Linux - Perlbrew and cpanminus

This is probably the most recommended way of installing the latest version of Perl and installing Perl modules.


## Linux - from the distribution

Many Linux distributions such as Ubuntu package Dancer2 and allow you to install it using the standard package management system.
For example on Ubuntu you could install it using the following command:

```
$ sudo apt-get install libdancer2-perl
```

For this you need to have `root`, or more precisely `sudo` rights. This is a very easy way to install Dancer.
It also has the advantage that using the exact same Linux distribution on multiple servers will bring you the exact same version of Dancer everywhere.

The big drawback is that we are using a rather old version of Dancer and some additional Perl modules that we might want to use will not be available with this method.
For those methods we'll have to use one of the CPAN clients to install the module.

TBD


## Installing Dancer with cpanm

Once you have Perl and cpanm installed we can start installing the Perl Modules we need

```
cpanm Dancer2
```

will install the latest edition of Dancer2 and pull in all the modules required by Dancer2.

Using this command is great if you'd like to get the latest and greates of all these modules, however this carries some risks.
If you run the same commend later you will potentially receive different versions of Dancer2 and the dependencies.
This command always installes the latest version of any missing module, but it won't upgrade any of the dependencies if
they already have an installed version that satisfies the requirements.

In most cases these differences won't have an impact on your application, but having different versions carries
some risk with it. There are several ways to ensure you have a specific version of each one of your the modules you require,
but implementing those are beyond the scope of this book.


