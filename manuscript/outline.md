## Outline {#outline}

This is the planned outline of the book.

### X - Installations and Setup

Before we can start writing code we have a slightly tedious task of [setting up our environment](#setup-environment). That is installing [Vagrant](#vagrant), [Perl](#install-perl), [Dancer2](#install-dancer), [IDEs](#ide), and a few other things. If you are impatient feel free to skip this part and jump ahead. You can always come back and read the setup later.

### X - Hello World

While the main focus of the book is creating Single Page Applications, first we are going to see a few examples of building web applications where we serve HTML pages. This is both simpler - we don't need to handle the JavaScript part - and we will also need this knowledge when we will want to add "content-heavy" pages to our web site that will be indexed by search engines. A little [SEO](#seo) won't hurt any of us!

In this chapter we will have our ["Hello World"](#hello-world) application in Dancer. We'll talk a bit about development environment. We will even write a simple unit-test to make sure our "Hello World" application works as expected.

### X - Multi-page application - static files

We go on building applications returning HTML pages. In this chapter we'll see an application with several pages. We will see how to use the `template` function to combine an HTML template with some data. We will also see how to create an application using multiple files. We will handle static files such as images and CSS files.

### X - Dancer Skeleton

We will create an application based on the [skeleton](#dancer-skeleton) provided by Dancer. We'll see what files does the skeleton contain and how we might use it to jump-start a new application.

### X - Deploy

In many book deployment is pushed to the end of the book if mentioned at all. This fits well the waterfall development approach. If however you'd like to have a more agile development process, you need to be able to show you application to the clients and you should be able to deploy your application. So now that we have covered the basics of Dancer, we will see how can we deploy our simple applications. In this chapter we will see how to [deploy](#deployment) an application to a Virtual Private Server (VPS).

As part of our deployment we'll discuss the need for security and the use of [HTTPS](#https).

### X - SPA Hello World

We create the first Single Page Application. It is the venerable ["Hello World"](#spa-hello-world) application as an SPA. This includes a simple AJAX request to get some data from the server to the application in the browser.

### X - SPA Echo

[Echo](#spa-echo) is our second SPA. Here we'll see how to send data to the server and get response to it. Once you have read this you can already go out to world an start building Single Page Applications. The rest is just fine tuning.

### X - SPA Calculator

We will see another SPA which is a bit more complex - a [calculator](#spa-calculator) that already accepts input from the user and provides some response. This includes a simple AJAX requests to send some data to the server, accept and process the response.

### X - Client input validation and error handling

Client side input validation can be used to improve usability. Without reaching the server and without incurring the delay caused by the network traffic we can check if the user has provided all the necessary input, if the input is in the expected format and/or in the expected value range.

### X

Server side input validation: While checking the input in the client can improve usability and the responsiveness of the web site, it cannot replace server side input validation. After all a person who might want to break in your service can circumvent the client side validation and send data directly to your back-end. You need to protect your service at that point.

### X - Server Side Errors

Server side error handling. What happens if there is an exception in the code?
What happens if the user tries to access a route without proper authentication?
What happens if the user does not supply the expected input, or supplies incorrect input? (e.g. a sting instead of a number).
What happens if the user tries to access a route that does not exist?

### X - HTML

I assume most if the readers are somewhat familiar with HTML and HTML5. Nevertheless a quick introduction to HTML is included.

### X - CSS

CSS - Cascading Style Sheets are both hated and loved by people. The 4th edition of the [Definite Guide of CSS](https://www.amazon.com/CSS-Definitive-Guide-Visual-Presentation/dp/1449393195?tag=szabgab-20) has 1090 pages and weight 3.7 pounds. We are going to cover the gist of it 2 pages and no pounds.

### X - jQuery

Selecting the JavaScript framework: the case for jQuery. An introduction to jQuery. There are plenty of modern JavaScript frameworks that generate a lot of noise. Some of them will surely stay around for a long time. jQuery is not that hyped any more, but is probably still the most widely used framework. We will get a small taste of it here. Enough to get started with our Single Page Application.


### X - Bootstrap

Introduction to Bootstrap, the HTML/CSS framework. It is fun to hand-craft your own web site using HTML and CSS, but between you and me, no all of us can make beautiful site. I know I can't. So we can rely on the engineers at Twitter and use Bootstrap. There might be a lot of sites look the same because many people use Bootstrap, but it is much better than having many site look equally horrible because of hand-crafted HTML and CSS..


### X - Authentication and Authorization

How to verify that a visitor is the person she claims to be? Can she access a certain page? Can she execute a certain operation?

### X - Session management

What is a session?

### X - SEO

When to use an SPA and when to avoid it, an [SEO](#seo) perspective. Search Engine Optimization got a bad reputation due to people trying to exploit the weaknesses of the search engines to rank higher. With the improvement of the algorithms in Google, the work that used to be done in dark alleys is mostly gone. Yet there are several things a web site owner can do that will improve their ranking on Google and thus generate more traffic to the web site.

# X Other

* A simple route returning the HTML page that will house the rest of the application
* Designing and implementing an API
* Testing the back end API
* Pages: client side routing
* Submitting a form

