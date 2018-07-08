# Static Files

The core of the application might be the HTML or the data we compute and send back to the clients, but there are also some files that are fixed. For example CSS files that contain the style sheets are static. They might change from release-to-release but not from request-to-request. Same with JavaScript files. Images, mp3, and mp4 files, and maybe a few other formats.

There is usually no need to serve these files by Dancer and indeed when we set up our production environment we'll configure our web server to serve these files directly without talking to Dancer. During development however you probably don't have the production environment, but we still need to see the content of these static files.

For that Dancer provides a solution. Any file located in the `public` directory of the project will be served as it is by Dancer.

## CSS file

In order to have a static CSS file we need to create a directory called `public`. We could put the CSS file in that directory, but it is probably better to organize the static files according to file type. So we created a subdirectory called `public/css/` and put the file `style.css` in it. It does not have a lot of content. We would only want to see how all this works.

![code/with-static-files/public/css/style.css](code/with-static-files/public/css/style.css)

In our layout we added a line to the header to load the CSS file:

```
<link rel="stylesheet" href="/css/style.css">
```

The whole file looks like this:

![code/with-static-files/views/layouts/main.tt](code/with-static-files/views/layouts/main.tt)

I've even added a test case to the test script to check if the CSS loading line is in the HTML:

```
like( $res->content, qr{<link rel="stylesheet" href="/css/style.css">}, 'css found' );
```

though this only checks if it is in the HTML. It does not check if the browser can load it or not.

## Images

In order to add images I've created a directory called `public/images` and copied the logo of Dancer to it:

![code/with-static-files/public/images/dcr-header-logo.png](code/with-static-files/public/images/dcr-header-logo.png)

This I wanted to only show an a specific page so added

```
<img src="/images/dcr-header-logo.png">
```

to the `views/index.tt` file that looks like this now:

![code/with-static-files/views/index.tt](code/with-static-files/views/index.tt)

For that too I've added a test case:

```
like( $res->content, qr{<img src="/images/dcr-header-logo.png">}, 'image found' );
```

## How it looks like

If we launch the application now:

```
plackup -R lib/ bin/app.psgi
```

and browse to `http://127.0.0.1:5000/` we will see

![With static files](images/with-static-files.png)

## Verify Content-Type

We can also check that Dancer properly sets the Content-Type on the static files based on their extension. If we use `curl` with the `-I` flag we can see the HTTP header sent back by the server.


For the main HTML page it is `text/html`:

```
curl -I http://127.0.0.1:5000/
```

```
HTTP/1.0 200 OK
Date: Thu, 16 Nov 2017 16:01:35 GMT
Server: HTTP::Server::PSGI
Server: Perl Dancer2 0.205002
Content-Length: 223
Content-Type: text/html; charset=UTF-8
```


For the CSS file it is `text/css`:

```
curl -I http://127.0.0.1:5000/css/style.css
```

```
HTTP/1.0 200 OK
Date: Thu, 16 Nov 2017 15:45:14 GMT
Server: HTTP::Server::PSGI
Content-Type: text/css; charset=utf-8
Content-Length: 29
Last-Modified: Thu, 16 Nov 2017 10:32:10 GMT
```

For the PNG image file it is `image/png`:

```
curl -I http://127.0.0.1:5000/images/dcr-header-logo.png
```

```
HTTP/1.0 200 OK
Date: Thu, 16 Nov 2017 15:59:56 GMT
Server: HTTP::Server::PSGI
Content-Type: image/png
Content-Length: 26356
Last-Modified: Thu, 16 Nov 2017 15:47:41 GMT
```

## Test the HTML

The full code of the test script is here:

![code/with-static-files/t/multi.t](code/with-static-files/t/multi.t)

