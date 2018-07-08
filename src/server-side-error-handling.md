# Server Side Error handling

What should happen if there is an error in the server?

What should happen if there is an exception while running the Perl code on the server?

What should happen if a request arrives to a route that is not implemented in the server?

What if the code on the server notices that the input received from the client is not what the server expects? For example the clients sent in a string where the server expected a number. Or if the client sends in a username in a registration form that is longer than what we would like to accept? Or if the client sends in an e-mail address that is invalid? Can we verify this?

For every request the server will provide some response that will include an [HTTP status code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) from the HTTP specification, some additional headers (e.g. Content-type) and some content. Dancer provides a default behavior for some of the errors mentioned above. If there is an exception in the code it would return a 500 error. If no matching route was found it would return a `404 Not Found`. In both cases the default is to return an HTML page. For both cases the developer can create template files to be used instead of the default pages. This allows the developers to create fancy error pages for the casual visitors. In addition, developers usually create special pages for the unauthorized access case. For example if a client tries to access a private page without login in or if one user tries to access the private pages of another user.

If we are developing an API then returning an HTML page with some content and tons of markup is probably not a good idea. It would probably be better to return some JSON structure that contains information on the error and some pointers on how to fix them, if this is something the user can fix.

## Common HTTP status codes {#http-status-code}

There are a lot of [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) divided into several categories.

* 1xx Informational responses
* 2xx Success
* 3xx Redirection
* 4xx Client errors
* 5xx Server errors

There are about a 100 status codes among those categories, but only a handful is in common use.

Probably the most common status code is `200 OK` that means the request was successful and you are getting the response now.

In the 3xx range the two commonly used codes are `301 Moved Permanently`, `302 Found` and `303 See Other` with the latter two used for the same "Temporary redirect"

The `redirect` function of Dancer automatically sets `302 Found`.
The `rewrite` of nginx set `301 Moved Permanently`.

`404 Not Found` is one of the most common error messages on the Internet. It happens if we try to access a page that does not exist. Either because we click on a wrong link, we have typed in the wrong URL, or because the page was removed and no redirect was put in place.

`500 Internal Server Error` is another very common error message. We will get it if there is an exception in the code. Either one that we ourself generated, for example a call to `open or die`, something a module we use generated, or because we have made some coding error, or because we have not verified the input and the user supplied some data we were not expecting.

`400 Bad Request` usually indicates bad input from the client.

`401 Unauthorized` when the client tries to access a page that requires authentication, but the user has not provided credentials. (e.g. the client trying to access the profile editing page, but have not logged in yet.)

`403 Forbidden` when the client tries to access a page that requires authentication and proper rights. The client has authenticated but does not have the privileges for the specific action. (eg. a user trying to see the private pages of another user, or a regular user trying to access admin pages.)


![code/errors/bin/errors.psgi](code/errors/bin/errors.psgi)

If we access a URL where the route throws an exception, e.g. by calling `die`, normally Dancer would return an HTTP code `500 - Internal Server Error` and a page that says the same.

```
curl -X POST -d "x=20&y=4" http://127.0.0.1:5000/api/calc
```

```
curl -X POST -d "x=20&y=0" http://127.0.0.1:5000/api/calc -D header.txt
```

![code/errors/lib/MySite.pm](code/errors/lib/MySite.pm)

![code/errors/lib/MyAPI.pm](code/errors/lib/MyAPI.pm)

![code/errors/t/errors.t](code/errors/t/errors.t)

![code/errors/public/errors.js](code/errors/public/errors.js)

![code/errors/views/index.tt](code/errors/views/index.tt)

```
curl -I http://127.0.0.1:5000/old-page

HTTP/1.0 302 Found
Date: Sun, 05 Nov 2017 16:12:04 GMT
Server: HTTP::Server::PSGI
Location: http://127.0.0.1:5000/
Server: Perl Dancer2 0.205002
Content-Length: 306
Content-Type: text/html; charset=utf-8
```

