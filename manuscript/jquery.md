# jQuery {#jquery}

[jQuery](http://jquery.com/) is a JavaScript library that makes it easy to write browser-independent code. It makes it easy to access elements on an HTML
page and manipulate them.

In order to use jQuery we need to load it into our HTML page and we need to add some jQuery code with the specific instructions.

We can load the jQuery library from our own server or from a CDN. (Where CDN stands for Contend Delivery Network.)
You can, for example use the official [jQuery CDN](https://code.jquery.com/).

The advantage of using jQuery from a CDN is that when a user arrives to your page she might have already visited another site that loaded the same version of jQuery.
In that case it is already cashed in her browser and your site will load faster.
The disadvantage is that you can't work on your application when you are offline as you don't have access to jQuery library.

Including jQuery in our project and using it from our own server has the advantage of it always available, even when we want to develop off-line.
It also means that visitors to our site will have to load jQuery which can be 86K-100K bytes. It is not huge, but it might have an impact on the user experience.

## jQuery for off-line development - best of both worlds

If we use jQuery from a CDN and then we go off-line to develop our code while not connected to the Internet we might have a problem.
If we are lucky and our browser cached the jQuery file then everything will work fine, but if the browser has not cached it, or if the cache has expired,
(for example because we loaded lots of other things and the disk limit forced the browser to discard the jQuery file we need for our site) then
we won't be able to develop.

There is a way however that will allow us to enjoy both worlds.

We can use the following HTML code with some embedded JavaScript code to first try to load jQuery
from the public CDN. If that fails then load it from our own server. (I've seen this in the skeleton created by the `dancer2` command.)

![code/jquery/alternative.html](code/jquery/alternative.html)

Here the first `script` tag refers to the jQuery file on the CDN.
The second `script` tag has a small JavaScript snippet in it that check if the object `window.jQuery` exists.
This is the object that would be created by the loading of the jQuery library.
If the object is does not exists then jQuery was not loaded. In that case we use `document.write` to paste a new `script` tag
in the HTML page right where we are. This will trigger the loading of jQuery from `/jquery-3.2.1.min.js` that refers to the
same server where the HTML page came from. That is our own server.

This code will only work properly if we load it from a server. So loading the above HTML page won't work.

Therefore we have the same example in a simple Dancer application where the only route we have is `/` and it return
a simple HTML with the above HTML snippet and some more HTML to actually show you that this works.

We have an empty `div` element with ID `text`. We also have some additional JavaScript code that will run when the whole document has rendered.
It will locate the element with the ID `text` and write in it `hi` and the current time created by the `Date()` JavaScript object.
We use the date so you can reload the page several times and see if it displays the content and if the content was updated since the previous load.

```
$().ready(function() {
    $("#text").html("hi "+ Date());
});
```

Here is the full version:

![code/jquery/bin/alternate.psgi](code/jquery/bin/alternate.psgi)

In order for this to work we need to create a directory structure. Put our psgi file in the `bin` subdirectory
and put the downloaded jQuery file in the `public` directory. Like this:

```
$ tree
.
├── bin
│   └── alternate.psgi
└── public
    └── jquery-3.2.1.min.js
```

We can download the jQuery file with our browser or by using `wget` on the command line:

```
wget https://code.jquery.com/jquery-3.2.1.min.js
```

We need the above layout as this is how Dancer operates by default. Any file we put in the public directory which is a
sibling of the bin directory where our psgi file is, will be served as a static file.

We can launch the application:

```
plackup -r bin/alternative.psgi
```

and then we can visit our web page to see if it works.

In order to really check if this works, you'll need an elaborate sequence of downloading different versions of jQuery and turning your Internet connection off and on
while trying the application. I'll let you figure our the order.

## CSS selectors in jQuery

[CSS](#css) has introduced us to a set of selectors that allow us to locate specific HTML tags of groups of HTML tags. jQuery allows us to use the same notation
to access elements on an HTML page.

We can use the following syntax to make use of CSS selectors that should come in the string:

```
$('')
```

Select all the `div` elements:

```
$('div')
```

Select the element with ID `name`:

```
$('#name')
```

Select the elements with class `ad`:

```
$('.ad')
```


## Accessing values in jQuery

Get the value from an input-box.

```
$('#txt').val();
```

Set text inside a tag:

```
<div id="result"></div>
```

```
$( "#result" ).html( "new content" );
```

![code/jquery/form_values.html](code/jquery/form_values.html)

## Pages

![code/jquery/pages.html](code/jquery/pages.html)

Use the anchor to mainatin history, allow external links and allow make back button work.

![code/jquery/pages_history.html](code/jquery/pages_history.html)

End.
