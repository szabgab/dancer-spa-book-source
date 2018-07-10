{sample: true}
## Development environment using Docker {#docker}
{i: docker}

[Docker](https://www.docker.com/) is the de-facto standard for containerization. Instead of installing many applications on the same server, and instead of settiing up separate linux boxes for each applications, Docker allows the use of the same Linux box with a good separation of applications.

Docker also makes it very easy to set up standardized development, testing and production environments for each application and regardless of the desktop Operating system used by the developers.

Docker is also light-weight. Much lighert than setting up a Linux box using [Vagrant](#vagrant).

In Docker an "image" is a disk and a configuration of a partial Linux box. When you run an image Docker creates a container and the container is the thing that actaually runs. When the container has finished running you can usually delete it and run the image again creating another containers.

While you can change the content of a container, people usually consider them as read-only assuming that anything written to it (e.g. temp files) will be gone soon.

### Start with Docker

[Install Docker](https://www.docker.com/) and make sure the Docker daemon is running. Run the following command:

```
docker run --rm hello-world
```

It will print something like this:

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
9bb5a5d4561a: Pull complete
Digest: sha256:3e1764d0f546ceac4565547df2ac4907fe46f007ea229fd7ef2718514bcec35d
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```

The first line tells you that it could not find the hello-world Docker image on your computer. The second line tells you that it is downloading the image.
Once the image was downloaded, Docker runs it. The only thing this Docker image does is printing some text to the screen. That's what you can see.  (The <hl>--rm</hl> option told Docker to remove the Docker container after it has finished running.)

This little exercise prooved that Docker works properly on your computer.

You can now list all the images on your compuer using

```
docker images
```

and you can remove the "hello-world" image using:

```
docker rmi hello-world
```

### Docker images

There a plenty of Docker images in the [Docker Hub](https://hub.docker.com/) we can start using.
I have created one of my own. I am going to explain how to build your own Docker image later on.
For now, let's see how to reuse the one I've already created.

Run the following command:

```
docker run --rm -it szabgab/ubuntu-perl-dancer2
```

At first it will complain that the image `szabgab/ubuntu-perl-dancer2` cannot be found locally and then it will donwload it. This will take some time and it will take up some space on your disk, but subsequent runs using the same image will be much faster. At the end of this operation you'll see a prompt like this:

```
root@1419cda365b8:~#
```

This happens because we supplied the `-it` flags. This means you are now inside the container on the command line. You can now runn commands like

```
perl -v
```

to see which version of Perl is available (5.26.1) or

```
perl -MDancer2 -E'say $Dancer2::VERSION'
```

to see which version of Dancer2 is available (0.205002).

Once you are done, you can exit by typing `exit`.

This will get you back to the prompt of your operating system. It will also remove the Docker container you used because we supplied the `--rm` flag. That means if you made any changes (installed more software using `apt-get` or `cpanm`, all those changes will be gone. (If you want to make them persistant, you'll have to create your own Docker image.)

## Running Hello World with Docker

Now we would like to use the Docker image as a stand alone executable and not in interactive mode.

```
docker run  --rm szabgab/ubuntu-perl-dancer2 perl -E 'say "hello world"'
```
This command runs our Docker image. The `--rm` flag tells tocker to remove the container after it has finished running. Then after the name of the image we type the code that goes on the command line. In this case a very simple Perl one-liner.

Feel free to play around with this now.

## Running Hello Dancer with Docker

```
docker run -v $(pwd):/root -p5001:5000 --rm --name dancer szabgab/ubuntu-perl-dancer2 plackup hello_world.psgi
```

The `-v $(pwd):/root` code will map the current working directory of the host system to the `/root` directory inside the Docker container. On Ms Windows you'll probably need to provide the current working directory in another way. Probably `-v %cd%:/root`.

The `-p5001:5000` maps port 5001 on the host operating system to port 5000 of the Docker container. You can use any port on your host, the only reason I used 5001 and not 5000 to make it easier to see which one is on the host and which one is on the Docker container.

`--rm` will remove the container after you are done.

`--name dancer` will set the name of the running container to 'dancer' instead of some random string.

Once we execute this command we can access the web application by visiting `http://localhost:5001` in our browser or using `curl`.

In order to stop the Docker  container run the following command in a separate terminal window:

```
docker stop -t 0 dancer
```

`-t 0` tells it to kill the container immediately. "dancer" is the name of the container we used when we ran it.

## TBD Building Docker image

![](code/docker/Dockerfile)

```
docker build -t my-dancer-app .
```

```
docker run --rm -it my-dancer-app
```

