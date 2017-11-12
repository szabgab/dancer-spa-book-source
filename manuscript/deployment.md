# Deployment {#deployment}


If you deploy inside your company then you probably already have a machine that your application is expected to run on. You might even have a dedicated system or a DevOps team that is responsible for the deployment of applications.

This might be also an application you are running on some desktop computer just to provide access to other employees to some of the resources on that machine.

If this is your own project, or if otherwise you have the freedom to choose where to deploy the application, you might want to select onf of the VPS providers.

There are several companies that provide Virtual Private Servers (VPS-es) "in the cloud" for a really low cost. I personally use [Digital Ocean](https://www.digitalocean.com/?refcode=0d4cc75b3a74) and [Linode](https://www.linode.com/?r=cccf1376edd5c6f0b8eccb97e0741a1f24584e43). In both places you can get a box for $5 / month. (Both of those links are affiliate links so if you use them to sign up to their services and if you stay long enough I get some money I can use to pay my own usage.)

In any case with a VPS you get a Linux both with your choice of Linux distribution on it and root access. You can install whatever software you need.

Although the $5/month machines are "small" they can still handle a lot of load and it is very easy to upgrade them by the click of a button.

You can run Dancer as a CGI application, but I'd only use it that way if I had no other option. It can be also used as a FastCGI application, but my recommended setup for Dancer deployment is to run your Dancer app in some PSGI enabled web server such as [Starman](https://metacpan.org/pod/Starman) or [Twiggy](https://metacpan.org/pod/Twiggy) and put a "real" web server such as [Nginx](http://nginx.org/) or [Apache](https://httpd.apache.org/) in front of it. The "real" web server are then configured as revers proxyes. When someone requests a static file such as an image, a CSS or a JavaScript file the web server servers them directly. For all the dynamic pages the "real" webserver forwards the request to the PSGI-compatible web server running your application.

I'd even call the latter "application server" if I did not fear it sounds too heavy.

## Set up VPS

I assume you'll be able to register at [Digital Ocean](https://www.digitalocean.com/?refcode=0d4cc75b3a74) or [Linode](https://www.linode.com/?r=cccf1376edd5c6f0b8eccb97e0741a1f24584e43) and create a VPS.

## Update the distribution

If you have a new VPS it is recommended to start by updating all the packages of your operating system. If this is an in-house server then you might have less control over it, I'd still recommend you to encourage the system administrators to update their Linux distributions.

If it is a Debian-based system such as Ubuntu, you'd run

```
sudo apt-get update
sudo apt-get upgrade
```

![code/nginx-demo.conf](code/nginx-demo.conf)

![code/starman_daemon.pl](code/starman_daemon.pl)

The official deployment guide is in [Dancer2::Manual::Deployment](https://metacpan.org/pod/Dancer2::Manual::Deployment).

