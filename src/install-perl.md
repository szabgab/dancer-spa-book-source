## Install Perl {#install-perl}

### Linux - compile Perl and use cpanminus

CPAN has [the instructions](https://www.cpan.org/src/README.html) how to download the source of Perl and how to compile and install it,
but let me repeat them here:

```
sudo apt-get install -y build-essential
```

This will install gcc, make, and whatever else is needed to build other projects.


```
wget https://www.cpan.org/src/5.0/perl-5.26.1.tar.gz
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



Installing the required modules using [cpanminus](https://cpanmin.us/). Don't get too worried if you visit the website of cpan minus. The only thing you'll find there is the compressed version of the installation script. The recommended way to download and install cpanminus is to run

```
$ curl -L https://cpanmin.us | perl - App::cpanminus
```

but that might not work for you. In any case you could split that command in two:

```
$ wget  https://cpanmin.us/
$ perl index.html App::cpanminus
```

The `wget` command will save the main page of the cpanmin.us website as `index.html`. Although it is saved as if it was an HTML file in fact it is the Perl script we saw on that page. We could rename the file to make it look more like a Perl script, but we don't need to. We can run it as it is. The second command executes the content of the index.html file with the current perl and passes 'App::cpanminus' as argument.

This will install the latest edition of CPAN Minus, the popular CPAN client. You can verify that the installation was successful by typing:

```
$ which cpanm
```

and observing that it found the command in the expected place. In my case it printed:

```
/home/ubuntu/perl-5261/bin/cpanm
```

### Linux - Perlbrew and cpanminus

This is probably the most recommended way of installing the latest version of Perl and installing Perl modules.

### MS Windows - Strawberry Perl

If the computer you are using runs MS Windows you can either use some virtualization technique to run your Perl development environment on Linux, or you can run Perl natively.

If you prefer to work on MS Window natively then my recommendation is to install the latest release of [Strawberry Perl](http://strawberryperl.com/). It has an msi installer file. Once you installed it, you can open a Command Prompt and use `cpanm` to install the modules you need.

If you prefer virtualization and using Linux then check out the part about [Vagrant and VirtualBox](#vagrant).

### MS Windows - Active Perl

[ActiveState](https://www.activestate.com/) provides a free community edition of its [Active Perl](https://www.activestate.com/activeperl) distribution. You can use that as well on MS Windows.

### Mac OSX

OSX is just Unix underneath you can easily compile and install Perl. You can use some virtualization to run a Linux guest system inside OSX. For that consult the [Vagrant and VirtualBox](#vagrant) section.

Otherwise you can follow the instructions on how to install Perl on Linux.


### Mac OSX - Homebrew

[Homebrew](https://brew.sh/) is an open source package management system for Mac OSX. It provides lots of tools that you will need in your development life. Including perl. Once you've installed Homebrew you can type in

```
brew install perl
```

and it will download and intall a recent version of Perl.

