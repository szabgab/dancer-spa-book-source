## Development environment using Vagrant {#vagrant}
{#virtualbox}

VirtualBox allows you to install a new operating system inside your existing operating system without
making any changes to your existing operating system. From the point of view of your current operating
system it will be seen just as a directory with a few files in it you can delete any time.
This allows you to have a full-blown Linux on top of your Windows machine. Then you can use that Linux
machine without creating a mess for others in the family who might be using the same machine.

Vagrant is a command line tool that makes it easy to manage VirtualBox instances.


* Download and install the latest version of [VirtualBox](https://www.virtualbox.org/).
* Download and install the latest version of [Vagrant](https://www.vagrantup.com/).
* Create a directory where you'll have your Vagrant configuration file.
* Open the Terminal or Command Prompt and change directory to the one you've just created.
* Type: `vagrant init ubuntu/zesty64`

This means we base our virtual environment on the Zesty64 release of [Ubunty](https://www.ubuntu.com/).
According to the [releases list](https://wiki.ubuntu.com/Releases) Zesty is Ubuntu 17.04 released in April 2017.

By the time you are reading this book Ubuntu might have released newer versions of it Operating System.
Feel free to use the most recent version. Most likely the rest of the book and all the examples will work there too.

The output of the `vagrant init` command will look like this:

```
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

It will create a file called `Vagrantfile` in the current directory.

We need to make some adjustment to this file.
Edit the Vagrantfile with your favorite text editor and add two lines that will map the ports of the guest operating system. The guest operating system
being the one we are going to install now and the host operating system that runs on your computer.

```
  config.vm.network "forwarded_port", guest: 5000, host:5000
  config.vm.network "forwarded_port", guest: 3000, host:3000
```

By default Vagrant allocates 1Gb memory to the guest operating system. In most cases this is enough,
but if you are using Rakudo Perl 6 and want to compile it on your own you'll need to increase the allocated memory to 2Gb.

Change the line `vb.memory` to `vb.memory = "2048"`.

This is the Vagrant file I have:

{format: ruby}
code/Vagrantfile code/Vagrantfile.txt


* Then you can type in `vagrant up`.

This will start the Virtual Machine. The first time you run this, the command will need to download the image and thus it might take some time. Once it is done you get back the prompt of your host operating system.

* Then you can type the command that will take you into the guest operating system where you'll see a prompt like this:

```
ubuntu@ubuntu-zesty:~$
```

### Linux, Mac OSX

The command to ssh into the guest operating system:

`vagrant ssh`

### MS Windows

On MS Windows you can use [Putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)
to connect to the Vagrant based VirtualBox image.

You will need to download both putty.exe and puttygen.exe.
You can then follow [these instructions](https://www.sitepoint.com/getting-started-vagrant-windows/).

Once you installed the private key, Putty will let you connect to the virtualbox. It will still prompt
for a username though, where you need to type in 'vagrant'.

### Installing Linux environment

At this point you need to follow the instructions on how to set up the development environment on Linux.
Once you are done with that you can do all the rest of the tasks using this Virtual Box.

When you stop working on the project, you can leave the guest operating system by typing `exit`
that will take you back to the command prompt of the host operating system. You can now shut down
the VirtualBox image by typing: `vagrant halt`.

The next time you'd like to use the VirtualBox image you need to `cd` to the same directory and type
`vagrant up`. This time it should be much faster as you already have the image locally.
Then you can type `vagrant ssh` and it will move you into the guest operating system.


