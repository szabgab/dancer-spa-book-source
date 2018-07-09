# User Input {#user-input}

In HTTP there are two ways to pass values from the user to the server. The GET parameters at the end of the URL after a `?` character or the POST parameters in the body of the request. To this Dancer adds a 3rd way for accepting parameter as part of the path in the URL.

Let's say the user, or more precisely the author of the application, wants to pass two values from the client to the server:

```
fullname = Foo Bar
email = foo@bar.com
```

The URL would look like this, if passed as GET parameters:

```
https://code-maven.com/page?fullname=Foo+Bar&email=foo%40bar.com
```

If the values were passed as POST parameters we would not be able to see them. The URL would be "clean", the data would be passed in the body:

```
https://code-maven.com/page
```

Passing the values in the path of the URL could look like this:

```
https://code-maven.com/page/Foo Bar/foo@bar.com
```

Let's now see how to do either of these 3 in Dancer.

For our purposes the application will just echo back the values it received from the user.

## GET {#user-input-get}

Implementation of the GET method:

![](code/user-input-get.psgi)

In this we see two routes. The first one will react when the user visits the root of the web site `/`. It is a simple route that will return some text that happens to be HTML. It contains an HTML form with two field. We can run the above code using:

```
plackup user-input-get.psgi
```

We can then visit `http://0:5000/` and see the following:

![Input form](images/input-form.png)

If you fill the form and click on the "Send" button you'll see something like this:

![GET request submitted](images/input-form-get.png)
{i: query_parameters}

Alternatively, if you have `curl` on your computer, run the following command:

```
curl 'http://localhost:5000/echo?fullname=Foo+Bar&email=foo%40bar.com'
```

It will print this repsponse:

```
       <table>
          <tr><td>Full name:</td><td>Foo Bar</td></tr>
          <tr><td>Email:</td><td>foo@bar.com</td></tr>
       </table>
```

In both of these case what we see was the response of the second route, the one that was executed when the user accessed the `/echo` path on the server. Dancer provides an object called `query_parameters` that has a method called `get` that will return the value of the parameters passed by the user.



## POST {#user-input-post}
{i: body_parameters}

Implementation of the POST method:

![](code/user-input-post.psgi)

## Route {#user-input-route}
{i: route_parameters}

Implementation of the route method:

![](code/user-input-route.psgi)

