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
I have created one of my own.

![](code/docker/Dockerfile)

```
docker build -t my-dancer-app .
```

```
docker run --rm -it my-dancer-app
```

