## HTTPS - Secure communication {#https}

By default people use HTTP when setting up a web server and thus all the clients are communicating with web server via HTTP. In clear text. That means if someone manages to listen-in to the communication between you and the server, they can see the information you send to the server and the responses you receive. Though for random Joe or Jane it is not trivial to gain access to your communications, it is also not extremely difficult. In addition your ISP and all the routers between you and the server have full access to the traffic. It can provide great way to steal data from you. Impersonate you and in general ruin your day.

Showing how to sniff on a network is beyond the scope of this book, but I've written an article on [the importance of using HTTPS](https://perlmaven.com/pro/the-importance-of-https) showing how to monitor network traffic and how to see your passwords.

This kind of intrusion is bad for both the people using your service and to your service as well.

There are several ways you as the author of a web application can improve the security of your clients. Most importantly, you can switch your communication to use HTTPS.

HTTP as you probably know stands for [Hypertext Transfer Protocol](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol).

TLS stands for [Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security)

SSL stands for Secure Sockets Layer and it is just the old name of TLS.

HTTPS is [HTTP over TLS/SSL](https://en.wikipedia.org/wiki/HTTPS).

That is HTTP over a secure channel.

You can quite easily configure a server to talk HTTPS, but in order for the browsers of the world to recognize that you (the server) are really who you claim to be be you need to get a signed certificate from an accepted provider.

The easy and free way to get such a signed certificate is to use [Let's Encrypt](https://letsencrypt.org/).

In a nutshell, if you'd like to allow your users to send in private and personal details such as usernames, passwords, credit details in a secure and encrypted way then you must set up HTTPS.
