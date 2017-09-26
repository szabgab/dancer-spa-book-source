# SEO - Search Engine Optimization

Search Engine Optimization, or in short SEO is the act of getting Search Engines index the content of your site and display it high when people search for terms that are relevant to your subject.

Search Engines utilize bots (also called crawlers) to go over the pages of a web site, read their content and save them in the database of the Search Engine. Then there are various algorithms inside the Search Engine that index and rank the pages.

Single Page Application have only one HTML page. They might utilize the anchoring of HTML pages to provide the illusion of multiple pages and to allow the users to share specific pages by others,
but all that magic is created by JavaScript and it is lost on the bot of the Search Engines. In general a bot would only see a single page and even that might have no content.

So there is nothing to index. Your site will likely not show up on any of the searches.

That's not bad for a site that only has internal pages protected by some authentication scheme. Those pages don't need indexing by the public search engines anyway. However your site might
have a few additional pages explaining the service you provide. You probably want those pages to be indexed and you probably want them to rank high.

If you insist on using a Single Page Application even for the pages you'd like to be indexed, then there is an article on [optimizing Angular based SPAs for Google crawlers](https://moz.com/blog/optimizing-angularjs-single-page-applications-googlebot-crawlers) recommended by Andrew Solomon.

On the other hand if you prefer the easier route, you can have a Single Page Application for the internal site an a "regular" multi-page application for those pages that you'd want to be indexed.


