# HTML

This is a quick introduction to HTML.

TBD - a lot more is needed.

An HTML page is plain text page with tags in it that look like this `<name>`. A web browser can interpret those tags and display the text among those tags
and load additional files based on the instructions of those tags.
Some tags have a closing pair such as `<b>` and its closing pair `</b>`, other tags usually stand alone. For example `<img>`.
Each tag can have attributes. For example the `<img>` tag has a `src` attribute: `<img src="/images/name.png">` means fetch the image
at the URL given in the `src` attribute and display it inside the HTML page.  For some tags some of the attributes are rather critical.

What might be the most important for our purposed is that each element can have an attribute called `id`. Each ID should be unique inside an HTML
page though there is no enforcement of this uniqueness. If you happen to have two elements with the same ID some of the JavaScript code we'll write
may get confused though. So try to avoid that.

Sample:

```
<div id="name"></div>
```

Each element can also have an attribute called `class`. The same class value can, and usually is be repeated several times throughout a page.
Moreover each element can have a class that has several values in it separated by spaces. For example:

```
<div id="ad main"></div>
<div id="ad secondary"></div>
<div id="ad secondary"></div>
<div id="ad main"></div>
```

This allows us to address several tags at once and also two address similar tags in a number of ways. e.g. we can address all the elements with class 'ad',
or all the elements with class 'main'.


Some of the most important HTML elements and their usage:

* `html` - wraps the whole HTML document.
* `head` - wraps the header of the HTML page.
* `body` - wraps the content of the HTML page.

* `div` - a generic block element that will be show one under the other.
* `span` - a generic inline element that will be show in the same line as the surrounding content.

* `a` - an anchor element. It usually has an attribute called `href` that leads to another page. For example in this HTML snippet my name is the anchor text and normally this snippet would create a link the user can click on and would be take to my web site `<a href="https://szabgab.com/">Gabor Szabo</a>`.
* `img` an embedded image element. Has an attribute `src` that links to an image on our server or on another server.
* `ul` starts an unordered list.
* `ol` starts an ordered list.
* `li` a list element inside a list.


