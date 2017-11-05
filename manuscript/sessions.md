# Sessions {#sessions}

How can a server know that two separate requests come from the same user?

In some environments when a client talks to a server they open a channel and they talk back-and-forth that channel. In that case the server can know that all the requests in a specific channel come from the same client. HTTP, or "the web", that is the HTTP protocol, does not work that way. While there is some level of short-term connection re-use we cannot rely on that. 

When using a browser, or curl, or some other program you access a web site it does not know much about you. So how can it know that two requests came from the same person? The server might know your IP address, but several people can use the same IP address and as you move around and connect to different wifi networks you'll use different IP addresses. So we need another way to allow the server to differentiate between clients. It is actually not that difficult, but there are cerain aspects we need to be aware of. When a client connects to a server for the first time the server can generate a unique code and send that code to the client. Then, if the client decides to send that code back with subsequent requests, the server can know that this is the same client that asked the earlier request. Of course if someone can get hold that code then that person can pretend to be the original client. There are several ways to reduce this risk. Primarily by always using encripted communication. See [HTTPS](#https) for more details on encryting the connection.

The standard way to send the code to the client and for the client to send it back is using Cookies. A Cookie is just a simple string with some meta-data sent by the web server to the client in the header of the response. The browser stores the cookie in its own internal database and then on every subsequent request to the same server the browser includes the same cookie in the header of the request.

A few years ago the European Union mandated that every website that uses cookies (that is virtually every web site in the world) must display a warning to their European visitors and ask for their consent to store cookies in their browser. So now everty web site has such notification message.

## Who is on the other end?

The question is not that easy. The same person can use multiple computers or even just several different browsers on the same computer. How can the server know this is the same person?

The person might move around and access the service from different IP addresses, different time-zones and different countries while using the same computer and the same browser.

Several people might use the same IP address or even the same computer and the same browser. Usually all the computers of a company or a househole have the same public IP address. At home or at Internet Caffees several people use the same computer.

So we, the authors of a web application will have to decide if we care about requests from the same user or from the same browser.

In the terminology of web applications a "session" is a set of rquests and responses by the same user or by the same computer.

In order to identify that we have the same person sending the request A and request B we need to require some level of authentication.

The standard authentication is to provide a username and a password. The server could then verify that it has that username/password pair among the authorized users and give access to the visitor. If a user gets up from her computer, someone might sit down in front of it and keep using the application. We would have a hard time noticing that there is a different person on the other end. For example this can easily happen if someone uses a public computer in an Internet Caffe, airport, or a hotel. One solution would be to set a temporaty cookie that gets desctroyed when the browser is closed. This is a relatively good measure. Another option is to set the expirtion time of the cookie to a very short period of time. For example 1 minute. That means if the user gets up from the computer and no one starts to access our site within the one minute then the access rights are revoked. Of course this could be also annoying as this means even if I was just thinking for 1 minute or answering an e-mail, I'll be logged out and will have to enter my credentials again.

![code/sessions/bin/app.psgi](code/sessions/bin/app.psgi)

![code/sessions/lib/MyAPI.pm](code/sessions/lib/MyAPI.pm)

![code/sessions/lib/MySite.pm](code/sessions/lib/MySite.pm)

![code/sessions/t/session.t](code/sessions/t/session.t)

![code/sessions/public/session.js](code/sessions/public/session.js)

![code/sessions/views/index.tt](code/sessions/views/index.tt)

