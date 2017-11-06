# Sessions {#sessions}

How can a server know that two separate requests come from the same user?

In some environments when a client talks to a server they open a channel and they talk back-and-forth that channel. In that case the server can know that all the requests in a specific channel come from the same client. HTTP, or "the web", that is the HTTP protocol, does not work that way. While there is some level of short-term connection re-use we cannot rely on that. 

When using a browser, or curl, or some other program you access a web site it does not know much about you. So how can it know that two requests came from the same person? The server might know your IP address, but several people can use the same IP address and as you move around and connect to different wifi networks you'll use different IP addresses. So we need another way to allow the server to differentiate between clients. It is actually not that difficult, but there are certain aspects we need to be aware of. When a client connects to a server for the first time the server can generate a unique code and send that code to the client. Then, if the client decides to send that code back with subsequent requests, the server can know that this is the same client that asked the earlier request. Of course if someone can get hold that code then that person can pretend to be the original client. There are several ways to reduce this risk. Primarily by always using encrypted communication. See [HTTPS](#https) for more details on encrypting the connection.

The standard way to send the code to the client and for the client to send it back is using Cookies. A Cookie is just a simple string with some meta-data sent by the web server to the client in the header of the response. The browser stores the cookie in its own internal database and then on every subsequent request to the same server the browser includes the same cookie in the header of the request.

A few years ago the European Union mandated that every web site that uses cookies (that is virtually every web site in the world) must display a warning to their European visitors and ask for their consent to store cookies in their browser. So now every web site has such notification message.

## Who is on the other end?

The question is not that easy. The same person can use multiple computers or even just several different browsers on the same computer. How can the server know this is the same person?

The person might move around and access the service from different IP addresses, different time-zones and different countries while using the same computer and the same browser.

Several people might use the same IP address or even the same computer and the same browser. Usually all the computers of a company or a household have the same public IP address. At home or at Internet Coffees several people use the same computer.

So we, the authors of a web application will have to decide if we care about requests from the same user or from the same browser.

In the terminology of web applications a "session" is a set of requests and responses by the same user or by the same computer.

In order to identify that we have the same person sending the request A and request B we need to require some level of authentication.

The standard authentication is to provide a username and a password. The server could then verify that it has that username/password pair among the authorized users and give access to the visitor. If a user gets up from her computer, someone might sit down in front of it and keep using the application. We would have a hard time noticing that there is a different person on the other end. For example this can easily happen if someone uses a public computer in an Internet Cafe, airport, or a hotel. One solution would be to set a temporary cookie that gets destroyed when the browser is closed. This is a relatively good measure. Another option is to set the expiration time of the cookie to a very short period of time. For example 1 minute. That means if the user gets up from the computer and no one starts to access our site within the one minute then the access rights are revoked. Of course this could be also annoying as this means even if I was just thinking for 1 minute or answering an e-mail, I'll be logged out and will have to enter my credentials again.

## Save value in session

In this example we are going to have a web page with a text entry box and a button to "Set" the value. When the user clicks on the button the text typed in the input box will be sent to the server using an [Ajax](#ajax) call to send a POST request.


Project layout:

```
.
├── bin
│   └── app.psgi
├── lib
│   ├── MyAPI.pm
│   └── MySite.pm
├── public
│   └── session.js
├── t
│   └── session.t
└── views
    └── index.tt
```

The PSGI script is the same as we used earlier. It maps the two Dancer modules to the route `/` and the route `/api`:

![code/sessions/bin/app.psgi](code/sessions/bin/app.psgi)

The MySite module does not do anything interesting. It just returns the content of the main template saved in `views/index.tt`.

![code/sessions/lib/MySite.pm](code/sessions/lib/MySite.pm)

The template is also quite simple. In the `head` element first we load the jQuery library and then the JavaScript code we have for our page. In the `body` in the first pair of `div` elements we an `input` box and a `button` that will display "Set". These will be used to set a value. The second pair of `div` elements contain another button named "Get" and an empty `div` element that will be used to display the value saved by the "Set" operation.

![code/sessions/views/index.tt](code/sessions/views/index.tt)

When we open the page we see the following:

![Session - before](images/session_empty.png)

Let's look at the JavaScript code now.

![code/sessions/public/session.js](code/sessions/public/session.js)

`$().ready(` tells jQuery to execute the function passed to it when the HTML document is ready: after it was loaded and rendered by the browser. The anonymous function itself has two actions. The first `$("#set").click(` finds the element with `id` "set" (the button with "Set" written on it) and attaches a callback to the `click` event. That is, later, if the user clicks on the "Set" button this internal function will run.

![code/sessions/lib/MyAPI.pm](code/sessions/lib/MyAPI.pm)

We have two routes. Both serving the `/code` path. The first in the file handles the "POST" request to that path, the second one handles the "GET" request.

In the "POST" part first we copy the value received from the client via the "code" field to a temporary variable cleverly named `$code`. We do a little input validation. If `$code` is `defined` this means the user sent in some code. If that's true then we use the `session` function provided by Dancer to save the code under the key "code". By calling the `session` method Dancer checks if there is already a cookie that arrived from the client. If there was one then it reuses this cookie. If there was no earlier cookie then Dancer creates a new cookie. The session data itself, by default, is stored in the memory of the Dancer process itself. This means that if we stop our server the session information will be lost. This is ok for our current demonstration, but you'll probably want to use some more persistent storage. We'll discuss that later. The last statement in this part of the if-statement returns a JSON string created from the `result => 'set'` pair. This is the content that will be sent back to the client.
If, on the other hand, the `$code` was not `defined` we will want to indicate that there was a client-error. The client application sent in some data that was not according to our expectations.
So we set the [HTTP status](#http-status-code) to `400 Bad Request` and then return a JSON string with error message.

### curl

Run the server with `plackup bin/app.psgi` Then either use your browser to access http://127.0.0.1:5000/ or use `curl` in another terminal window.

```
curl --dump-header main_header.txt http://127.0.0.1:5000/
```
This will print the HTML template that can be found in `views/index.tt` and save the header in the file called "main_header.txt". The content of that file is:

![code/session/out/main_header.txt](code/session/out/main_header.txt)

```
curl --dump-header get_header.txt http://127.0.0.1:5000/api/code
{"result":null}
```

![code/session/out/get_header.txt](code/session/out/get_header.txt)

```
curl -X POST -d"code=qwerty" --dump-header header.txt http://127.0.0.1:5000/api/code
{"result":"set"}
```

![code/session/out/set_header.txt](code/session/out/set_header.txt)

```
Set-Cookie: dancer.session=WgBrIAAAQhRFNGXo89g-LhQYxN5rUmgf; Path=/; HttpOnly
```

If at this point we send another `get` request using `curl http://127.0.0.1:5000/api/code` we will get back the same `null` result as we did earlier.

On the other hand if we take the Cookie from the saved header file and send it back using the `--cookie` flag then the server will associate this request with the previous session and returned the string we stored previously.

```
curl --cookie "dancer.session=WgBrIAAAQhRFNGXo89g-LhQYxN5rUmgf" --dump-header header.txt http://127.0.0.1:5000/api/code
{"result":"qwerty"}
```

![code/session/out/get_with_cookie_header.txt](code/session/out/get_with_cookie_header.txt)


### Test

![code/sessions/t/session.t](code/sessions/t/session.t)



