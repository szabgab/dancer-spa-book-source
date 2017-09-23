# Install Dancer {#install-dancer}

Dancer, or more specifically Dancer2 is a Perl module distributed via [CPAN, the Comprehensive Perl Archive Network](https://www.cpan.org/).
There are many ways to install a Perl module depending on your operating system and your preferences.

## Linux - compile Perl and use cpanminus

CPAN has [the instructions](https://www.cpan.org/src/README.html) how to download the source of Perl and how to compile and install it,
but let me repeate them here:

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



