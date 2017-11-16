# Using Templates {#using-templates}

In our previous examples the HTML code we sent back to the client was embedded in the Perl code. First in the psgi file and then in the pm file. They ware also very short and simple HTML snippets. We also had them ready up-front. We did not have to include and dynamic data in the HTML. (e.g. showing the results of a query or even just displaying the current time.) Including a larger chunk of HTML will look horrible. Trying to include values in that HTML would become quickly unmaintainable. We have been there during the early years of web development.

Instead of that these days we put HTML templates in separate files. Each template contains an HTML page and some additional markup in the templating language. Then we use some the template engine to take a set of data, process the HTML template replacing the placeholders by the values and thus generate an HTML page that can be sent back to the client.

Dancer has such a templating system built in.

## Built-in Simple Templating system

The layout of our project changes a bit:


```
.
├── bin
│   └── app.psgi
├── config.yml
├── lib
│   └── MySite.pm
├── t
│   └── multi.t
└── views
    ├── index.tt
    └── other.tt
```

### Configuration

In order to use the basic templating system we need to turn it on as a configuration parameter. There are several ways to do that, but as we will want to add more configuration options, probably the best way is to create a file called `config.yml` in root of the project. It is a YAML file with very simple content:

![code/with-simple-templates/config.yml](code/with-simple-templates/config.yml)

What is YAML?

{aside}
### YAML - YAML Ain't Markup Language {#yaml}

YAML is a human friendly data serialization standard for all programming languages. It is similar in capabilities to JSON, but it enforces readability. It is primarily used for hierarchical configuration files. It allows us to create key-value pairs and lists of values in any depth. It usually starts with 3 dashes. Here is an example:

![code/sample.yml](code/sample.yml)

The indentation in the file represents the hierarchy. When converting to Perl this YAML file will be represented by a hash. In the above example we have a key called 'name' with a value of 'Foo Bar'. It has another key called 'languages' for which the value is a list of items (Perl, JavaScript, and English). In the Perl hash it will become an array. The third key is 'contacts'. It has one value which is another hash. The internal hash has one key 'personal' for which the value is another hash.

This Perl script will load the YAML file provided on the command-line and print it out using the `Dumper` function of `Data::Dumper`. This might help understanding how a YAML file is converted to a Perl data structure.

![code/dump_yml.pl](code/dump_yml.pl)

If we run `perl dump_yml.pl sample.yml > sample_yml.txt` we get the following output:

![code/sample_yml.txt](code/sample_yml.txt)

Similar to JSON, YAML is also supported by a plethora of programming languages, but unlike JSON, it is very easy to read and write. For a list of languages and libraries supporting YAML, visit the [home of YAML](http://www.yaml.org/).
{/aside}


### The routes in the Perl module

In the module implementing the routes each route will call the `template` function passing the name of the template file and a set of parameters as key-value pairs. The template function will load the appropriate file from the `views` directory of the project using the `.tt` extension. (I think this extension comes from the Template Toolkit which is another templating system we are going to review soon.) Then it will insert the values of the keys in the placeholders in the template and return the HTML string.

The call to `template` is usually the last call in a route and thus the route will return the HTML that was returned by the `template` call even if we don't call `return`. This is what you can see in the first route. Including the `return` keyword, as it is done in the second route is thus not required, but I prefer to be explicit. This will make it clear that the call to `template` also ends the route.

If someone accidently adds a new line of code after the call to `template` then the explicit `return` will make sure the extra code does not break the application.

![code/with-simple-templates/lib/MySite.pm](code/with-simple-templates/lib/MySite.pm)

### The templates

The templates themselves are located in the `views` directory:

![code/with-simple-templates/views/index.tt](code/with-simple-templates/views/index.tt)

![code/with-simple-templates/views/other.tt](code/with-simple-templates/views/other.tt)

They both include some HTML, a bit more than in our earlier examples, but still not something you'd want to show in public. The point though is that they have placeholders to be filled by the `template` function. `<% title %>` is such placeholder that will be filled by the value of the "title" field.


### Testing

If you have a full-blown HTML file with tons of markup, checking if a route returns exactly the same as we are expecting might not work well. It is usually better to only check for certain values or certain elements appearing on the page. This is what we are doing in our test. Instead of using the `is` function supplied by Test::More, we are using the `like` function. It accepts a string and a regex created by `qr`. If the regex matches the test passes. In each subtest we have a number of calls to `like` checking the presence of a number of HTML snippets.

![code/with-simple-templates/t/multi.t](code/with-simple-templates/t/multi.t)

### Simple Templating System

The built-in [simple templating system of Dancer](https://metacpan.org/pod/Dancer2::Template::Simple) is *really* simple. The only thing it supports is the interpolation of variables we have seen:

```
<% name %>
```

There is also a conditional that looks like this:

```
<% if var %>
  Show this if var is true
<% else %>
  Show this if var is false
<% end %>
```

but it is not even documented.

If you would like to do any serious web development you will need the fully supported conditionals, loops, support for deep data structures, include statement etc. Luckily Dancer2 also comes with two additional template systems: [Template Toolkit](https://metacpan.org/pod/Template) which is the know all do all templating system of Perl and [Template::Tiny](https://metacpan.org/pod/Template::Tiny) which is a subset of it. Actually Dancer uses a slightly modified version called [Dancer2::Template::Implementation::ForkedTiny](https://metacpan.org/pod/Dancer2::Template::Implementation::ForkedTiny).

We will take a look at using the Template Toolkit:

## Template Toolkit

The Template Toolkit is a drop-in replacement of the simple template. Or it would be if the default tags were the same, but they are not. By default the simple template system used angle-brackets: `<%  %>` while by default the Template Toolkit uses square brackets `[%  %]`. Don't worry though, we can change that in our configuration file which looks like this now:

![code/with-template-toolkit/config.yml](code/with-template-toolkit/config.yml)

We change the value of the `template` field to `template_toolkit` and added a few more values that will configure the Template Toolkit engine to use `<%` for opening tag and `%>` for closing tag.

If you make these changes to the previous example and run the tests using `prove`, you'll see that all the test are passing.

Now that we have switched to Template Toolkit, let's see what else can it provide beside variable interpolation? Of course we won't have a comprehensive description of TT, for that you might want to check out the [Template Toolkit book](https://www.amazon.com/Perl-Template-Toolkit-Scalable-Templating/dp/0596004761?tag=szabgab-20) or at least the documentation of TT.

## Template Toolkit


### Placeholders:

A few examples:

Variable interpolation
```
<% name %>
```

Loop over an array:

```
<% FOREACH lang IN languages %>
       <% lang %>
<% END %>
```

Conditional: IF-ELSE-END. The ELSE is optional. The END is the closing part and thus it is required.

```
<% IF condition %>
    ...
<% ELSE %>
   ...
<% END %>
```

### The template:

In our template you can see the above constructs. For example you can see how do we use the FOREACH loop display list items `li` elements:

![code/with-template-toolkit/views/other.tt](code/with-template-toolkit/views/other.tt)

### The Perl Module

There is not a lot of change in the Perl module, we just pass more key-value pairs to the `template` function, some of which have values that are themselves data structures.

![code/with-template-toolkit/lib/MySite.pm](code/with-template-toolkit/lib/MySite.pm)

### The test

We have some more tests. In order to verify the conditionals we check both side of the if-else-end conditionals. The side that we expect to see we check with `like`. The side that we expect not to see we check with `unlike`. This also checks if the regex matches, but the test-case fails if the regex matches and passes if the regex does not match.

![code/with-template-toolkit/t/multi.t](code/with-template-toolkit/t/multi.t)

## Multiple page types

If we have multiple pages that are only different in the content we fill using the template variables we will use the same template for each route. However if we have pages that differ in their general structure we'll have to use separate templates. For example in a blog engine each article has the same HTML structure we can use the same template. The main page however is different. It might list the title of the 10 most recent articles with some teaser to get people to read them. We might have other pages as well. For example a list of the titles of all the articles. An about-page with just plain text. etc. Each page-type will have its own template.

While each page-type has its own structure, they also have a lot of common things. After all we probably want to make sure all the pages look more-or less the same. We probably want to use the same CSS files for each one of them. We might want to have the same menu regardless of page type. This usually means that we want the top and the bottom part of the HTML, the header and the footer, if you wish, to be the same.

This poses a problem. If each template has a copy of header and the footer part then any change in them must be carried over to the others. You, or whoever updates the templates will forget this and soon you'll have minor differences. There are two commonly used solutions for this. One is that the page-templates only contain the distinct parts and include the header and footer from additional template files. The other one is using layouts. A "layout" is just a template that has a placeholder where the content of the page is inserted. In this case the template engine picks up the template of the page, processes it. Then picks up the template of the layout and processes that embedding the HTML generated from the page in the placeholder `<% content %>`. Dancer allows both method.

## Layouts

In order to use layouts we need to tell Dancer what is our default layout. We can do this in the `config.yml` file by adding the `layout` key with the name of the layout file.

![code/with-layouts/config.yml](code/with-layouts/config.yml)

The actual file is located in the "views/layouts" subdirectory and has an extension `.tt`.

The directory layout is similar to what we had earlier, with the additional "layouts" subdirectory:


```
.
├── bin
│   └── app.psgi
├── config.yml
├── lib
│   └── MySite.pm
├── t
│   └── multi.t
└── views
    ├── index.tt
    ├── layouts
    │   └── main.tt
    └── other.tt
```

### Templates and layout:

![code/layouts/views/index.tt](code/with-layouts/views/index.tt)

![code/with-layouts/views/other.tt](code/with-layouts/views/other.tt)

![code/with-layouts/views/layouts/main.tt](code/with-layouts/views/layouts/main.tt)


## Include header and footer

The other approach is to make the pages the main templates and let them include whatever they want. For this we definitely need to use Template Toolkit as the Simple template does not support the INCLUDE statement.

### Templates

Our templates now contain the INCLUDE statements:

![code/with-includes/views/index.tt](code/with-includes/views/index.tt)

![code/with-includes/views/other.tt](code/with-includes/views/other.tt)


I usually put the files to be included in a subdirectory of the "views" directory. This time it is called "incl". The header and footer template are here:


![code/with-includes/views/incl/header.tt](code/with-includes/views/incl/header.tt)

![code/with-includes/views/incl/footer.tt](code/with-includes/views/incl/footer.tt)

Other than these we don't need to make any changes.

The directory tree looks like this:

```
.
├── bin
│   └── app.psgi
├── config.yml
├── lib
│   └── MySite.pm
├── t
│   └── multi.t
└── views
    ├── incl
    │   ├── footer.tt
    │   └── header.tt
    ├── index.tt
    └── other.tt
```

