# HTML {#html}

This is a quick introduction to HTML, the [Hypertext Markup Language](https://en.wikipedia.org/wiki/Html).

TBD - a lot more is needed.

An HTML page is plain text page with tags in it that look like this `<name>`. A web browser such as FireFox, Chrome, Opera, or Internet Explorer can interpret those tags and display them and the text among those tags and load additional files based on the instructions of those tags. Some tags come in pairs such as `<b>` and its closing pair `</b>`, other tags usually stand alone. For example `<img>`. Each tag starts with a less-then character followed by the name of the tag followed by the greater-than character. Tags can have attributes that have values. For example the `<img>` tag has a `src` attribute: `<img src="/images/name.png">` means fetch the image at the URL given in the `src` attribute and display it inside the HTML page. Most of the attributes are optional, but for some tags some of the attributes are rather critical. For example and `img` tag does not have a lot of value without the `src` attribute.

What might be the most important for our purposed is that each element can have an attribute called `id`. Each ID should be unique inside an HTML page though there is no enforcement of this uniqueness. If you happen to have two elements with the same ID some of the JavaScript code we'll write may get confused though. So try to avoid that.

Sample:

{line-numbers=off, lang=html}
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


