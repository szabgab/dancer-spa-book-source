{sample: true}
## Outline {#outline}

This is the planned outline of the book.

### 1

Before we can start writing code we have a slightly tedious task of setting up our environment. That is installing Perl, Dancer2, and a few other things. If you are impatient feel free to skip this part and jump ahead. You can always come back and read the setup later.

### 2

We will have our "Hello World" application in Dancer. We'll talk a bit about development environment. The first application will be HTML only, not really a SPA. We might also take a look at the same "Hello World" as a SPA. This includes a simple AJAX requests to get some data from the server to the application

### 3

We will see another SPA which is a bit more complex - a calculator that already accepts input from the user and provides some response. This includes a simple AJAX requests to send some data to the server, accept and process the response.

### 4

We will create an application based on the skeleton provided by Dancer.

### X

In this chapter we will see how to deploy an application to a Virtual Private Server (VPS).

### X

Client side input validation can be used to improve usability. Without reaching the server and without incurring the delay caused by the network traffic we can check if the user has provided all the necessary input, if the input is in the expected format and/or in the expected value range.

### X

Server side input validation: While checking the input in the client can improve usability and the responsiveness of the web site, it cannot replace server side input validation. After all a person who might want to break in your service can circumvent the client side validation and send data directly to your back-end. You need to protect your service at that point.

### X

Server side error handling. What happens if there is an exception in the code?
What happens if the user tries to access a route without proper authentication?
What happens if the user does not supply the expected input, or supplies incorrect input? (e.g. a sting instead of a number).
What happens if the user tries to access a route that does not exist?

### X

When to use an SPA and when to avoid it, an SEO perspective.

* A simple route returning the HTML page that will house the rest of the application
* Introduction to Bootstrap, the HTML/CSS framework
* Creating content-heavy web pages for SEO
* Selecting the JavaScript framework: the case for jQuery
* Submitting data to the server and getting a response
* Client side error handling
* Designing and implementing an API
* Testing the back end API
* Pages: client side routing
* Submitting a form
* Authentication
* Session management

## Support {#support}

If you need support with Dancer you can get it in a number of channels.

There is a mailing list called dancer-users. You can find link to it on the [about](http://perldancer.org/about) page of the Perl Dancer web site. This is probably the best place if you have a question about Dancer. I am also lurking on this list so if something is unclear in the content of the book then feel free to ask there.

You can use IRC to chat with other Dancer developers. Connect to the #dancer channel on the irc.perl.org IRC server. You might use your own IRC client on your computer, or try this web based client: [Mibbit for Dancer](http://perldancer.org/irc).

[Perl Monks](http://www.perlmonks.org/) is the place to ask general Perl related questions.

Stack Overflow can be a good place to ask questions. Tag them with both [perl and dancer](https://stackoverflow.com/questions/tagged/dancer).

In order to get help with jQuery you can also use the [Stack Overflow with jquery](https://stackoverflow.com/questions/tagged/jquery) tag.

## Exercises

Reading a book is nice, but if you'd really like to learn how to build something you need to get your hands dirty. So as soon as possible you need to start implementing whatever you learned. The best might be to start building a project yourself. In any case I'll provide a few exercises that will try to make use of the things you might have already encountered in the book. If you need help you can always check out the various [support channels](#support).

* [Hello World](#exercise-hello-world)
* [Calculator](#exercise-calculator)


