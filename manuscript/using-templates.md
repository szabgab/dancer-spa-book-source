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

{aside}
### YAML - YAML Ain't Markup Language {#yaml}

YAML is a human friendly data serialization standard for all programming languages. It is similar in capabilities to JSON, but it enforces readbility. It is primarily used for hierachical configuration files. It allows us to create key-value pairs and lists of values in any depth. It usually starts with 3 dashes. Here is an example:
{/aside}


![code/sample.yml](code/sample.yml)

The indentation in the file represents the hierarchy. When converting to Perl this YAML file will be represented by a hash. In the above example we have a key called 'name' with a value of 'Foo Bar'. It has another key called 'languags' for which the value is a list of items (Perl, JavaScript, and English). In the Perl hash it will become an array. The third key is 'contacts'. It has one value which is another hash. The internal hash has one key 'personal' for which the value is another hash.

This Perl script will load the YAML file provided on the command-line and print it out using the `Dumper` function of `Data::Dumper`. This might help understanding how a YAML file is converted to a Perl data structure.

![code/dump_yml.pl](code/dump_yml.pl)

If we run `perl dump_yml.pl sample.yml > sample_yml.txt` we get the following output:

![code/sample_yml.txt](code/sample_yml.txt)

Similar to JSON, YAML is also supported by a plethora of programming languages, but unlike JSON, it is very easy to read and write. For a list of languages and libraries supporting YAML, visit the [home of YAML](http://www.yaml.org/).


### The routes in the Perl module

In the module implementing the routes each route will call the `template` function passing the name of the template file and a set of parameters as key-value pairs. The template function will load the appropriate file from the `views` directory of the project using the `.tt` extension. (I think this extension comes from the Template Toolkit which is another templating system we are going to review soon.) Then it will insert the values of the keys in the placeholders in the template and return the HTML string.

The call to `template` is usually the last call in a route and thus the route will return the HTML that was returned by the `template` call even if we don't call `return`. This is what you can see in the first route. Including the `return` keyword, as it is done in the second route is thus not required, but I prefer to be explicit. This will make it clear that the call to `template` also ends the route.

If someone accidently adds a new line of code after the call to `template` then the explicit `return` will make sure the extra code does not break the application.

![code/with-simple-templates/lib/MySite.pm](code/with-simple-templates/lib/MySite.pm)

### The templates

The templates themselves are located in the `views` directory:

![code/with-simple-templates/views/index.tt](code/with-simple-templates/view/index.tt)

![code/with-simple-templates/views/other.tt](code/with-simple-templates/view/other.tt)

They both include some HTML, a bit more than in our earlier examples, but still not something you'd want to show in public. The point though is that they have placeholders to be filled by the `template` function. `<% title %>` is such placholder that will be filled by the value of the "title" field.


### Testing

If you have a full-blown HTML file with tons of markup, checking if a route returns exactly the same as we are expecting might not work well. It is usually better to only check for certain values or certain elements appearing on the page. This is what we are doing in our test.

![code/with-simple-templates/t/multi.t](code/with-simple-templates/t/multi.t)

## Layouts

Dancer goes a step further. It uses two layers of templates for extra flexibility. 


## Template Toolkit

