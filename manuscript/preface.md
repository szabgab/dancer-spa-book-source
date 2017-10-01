# Warning

This is an early draft of the book. Don't expect anything.

# Preface

This book is about the creation of Single Page Applications using Dancer2.

Dancer2 is a rewrite of Dancer. Throughout the book I'll use the name Dancer everywhere where Dancer2 except of the code examples where the name is critical.

If you are interested in the differences between the two, check out the [article written by Sawyer](http://advent.perldancer.org/2014/2).

## Outline

This is the planned outline of the book.

### 1

Before we can start writing code we have a slightly tedious task of settin up our environment. That is installing Perl, Dancer2, and a few other things.
If you are impatient feel free to skip this part and jump ahead. You can always come back and read the setup later.

### 2

We will have our "Hello World" application in Dancer. We'll talk a bit about development environment.
The first application will be HTML only, not really a SPA.
We might also take a look at the same "Hello World" as a SPA.

### 3

We will see another SPA which is a bit more complex - a calculator that already accepts input from the user and provides some response.

### 4

We will create an application based on the skeleton provided by Dancer.

### X

In this chapter we will see how to deploy an application to a Virtual Private Server (VPS).

### X

Client side input validation can be used to improve usability. Without hitting the server and without incurring the delay caused by the network traffic
we can check if the user has provided all the necessary input, if the input is in the expected format and/or in the expected value range.

### X

Server side input validation: While checking the input in the client can improve usability and the responsiveness of the web site, it cannot replace
server sitde input validation. After all a person who might want to break in your service can circumvent the client side validation and send data directly
to your back-end. You need to protect your service at that point.

### X

When to use an SPA and when to avoid it, an SEO perspective.

* A simple route returning the HTML page that will house the rest of the application
* Introduction to Bootstrap, the HTML/CSS framework
* Creating content-heavy web pages for SEO
* Selecting the JavaScript framework: the case for jQuery
* Simple AJAX requests to get some data from the server to the application
* Submitting data to the server and getting a response
* Client side error handling
* Server side error handling
* Designing and implementing an API
* Testing the back end API
* Pages: client side routing
* Submitting a form
* Authentication
* Session management

## Support

If you need support with Dancer you can get it in a number of channels.

You can use IRC to chat with other Dancer developers. Connect to the #dancer channel on the irc.perl.org IRC server.
You might use your own IRC client on your computer, or try this web based client: [Mibbit for Dancer](http://widget01.mibbit.com/?autoConnect=true&server=irc.perl.org&channel=%23dancer).

[Perl Monks](http://www.perlmonks.org/) is the place to go to ask generic Perl related questions.

Stack Overflow can be a good place to ask questions. Tag them with both [perl and dancer](https://stackoverflow.com/questions/tagged/dancer).

In order to get help with jQuery you can also use the [Stack Overflow with jquery](https://stackoverflow.com/questions/tagged/jquery) tag.

## Exercises

Reading a book is nice, but if you'd really like to learn how to build something you need to get your hands dirty.
So as soon as possible you need to start implementing whatever you learned.
The best might be to start building a project yourself.
In any case I'll provide a few exercises that will try to make use of the things you might have already encountered in the book.
If you need help you can always check out the various [support channels](#support).

* [Hello World](#exercise-hello-world)
* [Calculator](#exercise-calculator)

