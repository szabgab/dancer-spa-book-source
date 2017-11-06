# HTML {#html}

This is a quick introduction to HTML, the [Hypertext Markup Language](https://en.wikipedia.org/wiki/Html).

An HTML page is plain text page with tags in it that look like this `<name>`. A web browser such as FireFox, Chrome, Opera, or Internet Explorer can interpret those tags and display them and the text among those tags. It can also load additional files based on the instructions in those tags. Some tags come in pairs such as `<b>` and its closing pair `</b>`, other tags usually stand alone. For example `<img>`. Each tag starts with a less-then character followed by the name of the tag followed by the greater-than character. Tags can have attributes that have values. For example the `<img>` tag has a `src` attribute: `<img src="/images/name.png">` means fetch the image at the URL given in the `src` attribute and display it inside the HTML page. Most of the attributes are optional, but for some tags some of the attributes are rather critical. For example and `img` tag does not have a lot of value without the `src` attribute.

What might be the most important for our purposes is that each element can have an attribute called `id`. Each `id` should be unique inside an HTML page though there is no enforcement of this uniqueness. If you happen to have two elements with the same `id` some of the JavaScript code we'll write may get confused. So try to avoid that.

Example:

{line-numbers=off, lang=html}
```
<div id="name"></div>
```

This is a `div` element with an `id`.

Each element can also have an attribute called `class`. The same class value can, and usually is repeated several times throughout a page.
Moreover each element can have a class that has several values in it separated by spaces. For example:

```
<div class="ad main"></div>
<div class="ad secondary"></div>
<div class="ad secondary"></div>
<div class="ad main"></div>
```

This allows us to address several tags at once and also two address similar tags in a number of ways. e.g. we can address all the elements with class 'ad',
or all the elements with class 'main'.

## HTML elements

Some of the most important HTML elements and their usage:

* `html` - wraps the whole HTML document. It usually has a `head` followed by a `body` in it and nothing else.
* `head` - wraps the header of the HTML page. Usually meta-information about the page can be found inside.
* `body` - wraps the content of the HTML page.

* `title` - this comes inside the `head`. The content of the `title` is what will be displayed on the tab of your browser.

* `div` - a generic block element that will be shown one under the other.
* `span` - a generic inline element that will be showm in the same line as the surrounding content.

* `a` - an anchor element. It usually has an attribute called `href` that leads to another page. For example in this HTML snippet my name is the anchor text and normally this snippet would create a link the user can click on and would be take to my web site `<a href="https://szabgab.com/">Gabor Szabo</a>`.
* `img` an embedded image element. Has an attribute `src` that links to an image on our server or on another server.
* `ul` starts an unordered list.
* `ol` starts an ordered list.
* `li` a list element inside a list.
* `h1` .. `h6` - text header elements with descending importance. There should be only on `h1` element in every HTML document and that should be the main subject of the page.
* `p` - paragraph. Usually adds some empty space between the text above and the text below.
* `table`, `tr`, `th`, `td` are used to create a table. In the golden age of the Internet tables were used to enforce some layout on the page. These days this is not necessary and frowned upon to the point that some people use `div` elements even when they show tabular data. Don't be that person. Use `table` elements when you try to show a table of values.

* `script` - allows use to load an external JavaScript file `<script src="/code.js"></script>` or to embed JavaScript code in our HTML page.
* `input` - input box
* `form`  - a form - a set of input boxes.
* `button` - used to create a nice button.

* `style` - allows us to embed [CSS](#css) in the HTML file.
* `link` - usually used in the `head`. Instructs the browser to load an external CSS file: `<link href="style.css" rel="stylesheet">`.

## HTML examples

### HTML title, h1, h2, h3, h4, h5, h6 tags

![code/html/title_and_h.html](code/html/title_and_h.html)

![HTML title and h tags](images/title_and_h.png)

### HTML ol, ul and li

![code/html/ol_ul_li.html](code/html/ol_ul_li.html)

![ol, ul, li](images/ol_ul_li.png)

### HTML ol types

The `type` attribute of the `ol` element will tell the browser how to count. Using Arabic numbers is the default, but we can also use lower and uppercase letters and Roman numbers.

![code/html/ol_types.html](code/html/ol_types.html)

![ol types](images/ol_types.png)


