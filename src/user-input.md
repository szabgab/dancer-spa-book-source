# User Input {#user-input}

In HTTP there are two ways to pass values from the user to the server. The GET parameters at the end of the URL after a <hl>?</hl> character or the POST parameters in the body of the request. To this Dancer adds a 3rd way for accepting parameter as part of the path in the URL.

Let's say the user, or more precisly the author of the application, wants to pass two values from the client to the server:

```
fullname = Foo Bar
email = foo@bar.com
```

The URL would look like this, if passed as GET parameters:

```
https://code-maven.com/page?fullname=Foo+Bar&email=foo%40bar.com
```

If the valus were pass as POST parameters we would not be able to see them. The URL would be "clean",
the data would be passed in the body

```
https://code-maven.com/page
```

Third choice is to pass the values in the path of the URL like this:


For our purposes the application will just echo back the values it received from the user.

## GET

Implementation of the GET method:

![](code/user-input-get.psgi)

In this we see two routes. The first one will react when the user visits the root of the web site `/`.
It is a simple route that will return some text that happens to be HTML. It contains an HTML form with two field.
When we visit



## POST

Implementation of the POST method:

![](code/user-input-post.psgi)

## Route

Implementation of the route method:

![](code/user-input-route.psgi)

