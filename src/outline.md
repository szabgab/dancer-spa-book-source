# Outline {#outline}

This is what you are going to read in the book. Feel free to jump to the section most relevant to you.

## Part 1

Setting up the environment. Creating tradition web sites that return HTML using Dancer.

### Installations and Setup

Before we can start writing code we have a slightly tedious task of [setting up our environment](#setup-environment). That is installing [Docker](#docker), [Vagrant](#vagrant), [Perl](#install-perl), [Dancer2](#install-dancer), [IDEs](#ide), and a few other things. If you are impatient feel free to skip this part and jump ahead. You can always come back and read the setup later.

### Hello World

While the main focus of the book is creating Single Page Applications, first we are going to see a few examples of building web applications where we serve HTML pages. This is both simpler - we don't need to handle the JavaScript part - and we will also need this knowledge when we will want to add "content-heavy" pages to our web site that will be indexed by search engines. A little [SEO](#seo) won't hurt any of us!

In this chapter we will have our ["Hello World"](#hello-world) application in Dancer. We'll talk a bit about development environment. We will even write a simple unit-test to make sure our "Hello World" application works as expected.

### Accepting parameters from the user

The natural next step is to create an application that can [accept parameters](#user-input) from the user. We'll use a very simple application to echo back the input provided by the user. We'll see all 3 types of parameters Dancer can handle.

### Multi-file application

Creating a web site using just one file might sound cool, but it is not very maintainable. For anything beyond the mosy simple cases we'd better separate HTML, CSS, JavaScript, and Perl files. In this chapter we will see how can we separate out the different parts of the web application creating a [multi-file application](#multi-file-application).

### Using Templates

We go on building applications returning HTML pages. In this chapter we'll see an application with several pages. We will see how to use the `template` function to combine an [HTML template](#using-templates) with some data. We will also see how to create an application using multiple files. 

### Static files

On every we site there are plenty of static files. Images, movies, CSS files, etc.
We will see how to handle such static files without working too hard.

### Dancer Skeleton

We will create an application based on the [skeleton](#dancer-skeleton) provided by Dancer. We'll see what files does the skeleton contain and how we might use it to jump-start a new application.

### Deployment

In many book deployment is pushed to the end of the book if mentioned at all. This fits well the waterfall development approach. If however you'd like to have a more agile development process, you need to be able to show you application to the clients and you should be able to deploy your application. So now that we have covered the basics of Dancer, we will see how can we deploy our simple applications. In this chapter we will see how to [deploy](#deployment) an application to a Virtual Private Server (VPS).

As part of our deployment we'll discuss the need for security and the use of [HTTPS](#https).

## Part 2

Single Page Applications

### SPA Hello World

We create the first Single Page Application. It is the venerable ["Hello World"](#spa-hello-world) application as an SPA. This includes a simple AJAX request to get some data from the server to the application in the browser.

### SPA Echo

[Echo](#spa-echo) is our second SPA. Here we'll see how to send data to the server and get response to it. Once you have read this you can already go out to world an start building Single Page Applications. The rest is just fine tuning.

### SPA Calculator

We will see another SPA which is a bit more complex - a [calculator](#spa-calculator) that already accepts input from the user and provides some response. This includes a simple AJAX requests to send some data to the server, accept and process the response.

### HTML

I assume most if the readers are somewhat familiar with [HTML](#html) and HTML5. Nevertheless a quick introduction to HTML is included.

### CSS

[CSS](#css) - Cascading Style Sheets are both hated and loved by people. The 4th edition of the [Definite Guide of CSS](https://www.amazon.com/CSS-Definitive-Guide-Visual-Presentation/dp/1449393195?tag=szabgab-20) has 1090 pages and weight 3.7 pounds. We are going to cover the gist of it 2 pages and no pounds.

### Bootstrap

Introduction to [Bootstrap](#bootstrap), the HTML/CSS framework. It is fun to hand-craft your own web site using HTML and CSS, but between you and me, no all of us can make beautiful site. I know I can't. So we can rely on the engineers at Twitter and use Bootstrap. There might be a lot of sites look the same because many people use Bootstrap, but it is much better than having many site look equally horrible because of hand-crafted HTML and CSS..

### jQuery

Selecting the JavaScript framework: the case for [jQuery](#jquery). An introduction to jQuery. There are plenty of modern JavaScript frameworks that generate a lot of noise. Some of them will surely stay around for a long time. jQuery is not that hyped any more, but is probably still the most widely used framework. We will get a small taste of it here. Enough to get started with our Single Page Application.

### Submitting a form in a SPA

In traditional web applications we use `form` elements to submit forms and each such submission will trigger the generation of a new HTML page on the serever. In SPA we need to collect the data from the form and send it to the back-end via an Ajax call while showing a new page to the user.

### Client side input validation and error handling

Client side input validation can be used to improve usability. Without reaching the server and without incurring the delay caused by the network traffic we can check if the user has provided all the necessary input, if the input is in the expected format and/or in the expected value range.

### Server Side input validation

Server side input validation: While checking the input in the client can improve usability and the responsiveness of the web site, it cannot replace server side input validation. After all a person who might want to break in your service can circumvent the client side validation and send data directly to your back-end. You need to protect your service at that point.

### Server Side Errors

[Server side error handling](#server-side-error-handling). What happens if there is an exception in the code?
What happens if the user tries to access a route without proper authentication?
What happens if the user does not supply the expected input, or supplies incorrect input? (e.g. a sting instead of a number).
What happens if the user tries to access a route that does not exist?

### Session management

What does it mean that a web application is stateless? 
How can know that two requests come from the same user? How well can we correllate two requests?
What is a [session](#sessions)? How to create and set cookies?

### Authentication and Authorization

How to verify that a visitor is the person she claims to be? Can she access a certain page? Can she execute a certain operation?

### SEO - Search Engine Optimization

When to use an SPA and when to avoid it, an [SEO](#seo) perspective. Search Engine Optimization got a bad reputation due to people trying to exploit the weaknesses of the search engines to rank higher. With the improvement of the algorithms in Google, the work that used to be done in dark alleys is mostly gone. Yet there are several things a web site owner can do that will improve their ranking on Google and thus generate more traffic to the web site.

### Pages: client side routing

On a traditional web site each page has its own URL and served by a route on the server. In a SPA we usually only have one HTML page. All the rest of the communcation with the server happens behind the scene. So how can we still have the concept of "pages" in a SPA? How can we ensure that the "Back" button of the browser indeed takes us the the previously shown page. If it is still available.

### Main Route

A simple route returning the HTML page that will house the rest of the application

### Designing and implementing an API

### Testing the back-end API

### Solutions

[Solutions](#solutions)

### Appendix

[Appendix](#appendix)




