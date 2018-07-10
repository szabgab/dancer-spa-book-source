# User Input {#user-input}

In HTTP there are two ways to pass values from the user to the server. The GET parameters at the end of the URL after a `?` character or the POST parameters in the body of the request. To this Dancer adds a 3rd way for accepting parameter as part of the path in the URL.

Dancers provides 3 objects: `query_parameters`, `body_parameters`, and `route_parameters` for GET, POST, and route parameters respectively. Each one of them has a method called `get` that given the name of a field that was potentially passed by the user, will return the value the user passed to it.

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
{i: GET}

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
{i: post}
{i: POST}

Implementation of the POST method:

![](code/user-input-post.psgi)

In this case the form returned from the main route imlementing the request to `/` contains `method="POST"`. This tells the browser that it should submit the data via a `POST` request. The route implementing the `/echo` path is also designated to handle only `POST` reuqest. We do that by starting the whole definition with the `post` keyword.

When you visit the main page of this application you see exactly the same as you did in the previous case. Just the HTML form. When you submit the input data, however, it will be slightly different:

![POST request submitted](images/input-form-post.png)

The address-bar will only contain the path to the page, not the data passed in.

Using `curl` you can run this:

```
curl -X POST -d 'fullname=Foo+Bar&email=foo%40bar.com' http://localhost:5000/echo
```

## Route {#user-input-route}
{i: route_parameters}

Implementation of the route method:

![](code/user-input-route.psgi)

In this case the main route does not return a form. It only includes a link. The reason is that HTML forms cannot pass values the way Dancer expects them. This is method of parameter passing is only really useful if we would like to create "nice URLs" or later when we are going to create APIs, where some other program sends in the request.

```
curl 'http://localhost:5000/echo/Foo+Bar/foo%40bar.com'
```

![Route request submitted](images/input-form-route.png)

## Submitting a form {#submitting-a-form}
{i: form}
{id: get}
{id: get_all}

![](code/form.psgi)


Visit the main page and see this (after filling the form):

![](images/form-filled.png)

Click on the submit button and see this:

![](images/form-response.png)

Alternatively, run the following `curl` command:

```
curl -X POST -d "oneliner=Hello World&password=Sick Rat&languages=perl&languages=kotlin&gender=neutral&vehicle=car&vehicle=elephant&ema@b.com" http://localhost:5000/echo
```

And get this response:

```

       <table>
          <tr><td>Oneliner:</td><td>Hello World</td></tr>
          <tr><td>Password:</td><td>Sick Rat</td></tr>
          <tr><td>Languages:</td><td>perl,kotlin</td></tr>
          <tr><td>Gender:</td><td>neutral</td></tr>
          <tr><td>Vehicle:</td><td>car,elephant</td></tr>
          <tr><td>Email:</td><td>a@b.com</td></tr>
       </table>
```

The `curl` command shows that we don't actually need all that HTML for in order to pass in some values. It also hhighlights the fact that using `curl` or any other similar technologies, we can submit any data. Regardless of he values in the HTML page.

