---
published: true
title: The Static CMS
author: CM Lubinski
layout: post
---

Despite the recent advances and enthusiasm in the database space, there is a growing segment of developers who argue that dynamically generated content is overkill for most web sites. Individual blogs, brochure websites, and other content publishing apps are incredibly read heavy, and their content changes very infrequently. Further, modern content management systems (CMSes) require constant vigilance as new-found vulnerabilities are discovered each day and incompatible versions are released every few years.

An alternative has emerged via statically generated sites, which aim to solve or alleviate many of these problems by rendering all of the pages ahead of time. Instead of fetching content from a database or API with each page request, they need it only once, at compile time. Pages are most often generated as flat HTML files, giving you a complete, file-system-based page cache. There are no logins, no public-facing cgi scripts, and no need for application hardening. Versioning of your content becomes trivial as both the content files and their generated output can live in version control. To top it off, removing the need for a server-side scripting language will not only improve page load times, it will also reduce hosting prices. GitHub alone hosts thousands of static sites free of charge.

## Content

Traditional CMSes store their data structures within a relational database; these models can be created and edited through a web interface, which must therefore be protected. While static CMSes *could* use a similar approach, more often you will find content saved in flat files on the disk. For blogs, this might mean a series of markdown files with predictable file names; for a brochure site, the content might be directly or partially saved as pure HTML. [Prose.io](http://prose.io) (with which this article was written) provides a web-based editor for markdown files stored on Github that integrates well with Jekyll, but there are also numerous local markdown editors for various operating systems. 

Our content is generally wrapped in layouts (as we would expect in any CMS,) but what about additional fields and other structured data? Most generators allow their content to include (or be entirely composed of) YAML-based attributes. YAML, a superset of JSON, allows you to create data structures of arbitrary complexity with each piece of content. Using consistent attributes like "tags", "author", "published", etc. allows the static site generator to access these attributes in a predictable way. Prose.io has even advanced to the point where it can be configured to abstract the yaml attributes into HTML input fields.

Further, as static site generators are basically just scripts, they can be extended to allow additional data sources. Use a MySQL driver to query a database or connect to an API to download the latest content when generating pages. Really, anything that you could imagine happening on a traditional CMS can happen during the static site generation phase, the output simply remain the same between HTTP requests. Note that, due to automation, the frequency of "updates" can be as granular as desired.

## Jekyll and Nanoc

At the moment, Jekyll is the most popular static site generator available in no small part due to GitHub. The massively popular code sharing site allows for static content via a "safe-mode" version of Jekyll; search for "gh-pages" for a how-to. At first glance, Jekyll seems tailor made for publishing blogs, offering easy setup for content with publication dates, authors, tags, etc. The software also allows static html pages and generic, YAML "data", which can be accessed through ERB templates. Outside of the safe-mode, it can be extended with [plugins](http://jekyllrb.com/docs/plugins/) to execute arbitrary Ruby code. Unfortunately, plugins are more or less the only way to escape some of Jekyll's more assertive idioms (e.g. file naming conventions.)

An alternative which I've grown to prefer is Nanoc, also written in Ruby. Unlike Jekyll's blog-focused style, Nanoc processes content abstractly, mirroring a traditional CMS. Categorize content by adding a "type" field as a string (or list of strings); alternatively, use duck typing to filter content to only those that have certain fields. Nanoc generally matches Jekyll's YAML meta data plus Markdown body, but it also allows for YAML-only content, and content that can be generated on the fly (e.g. from SQL.) This tool is a wee bit more advanced than Jekyll and has a steeper learning curve, but certainly clicks better for my programmer mind and feels much more flexible.

## Dynamism

This attitude is a bit too idealistic, however, as many sites cannot rely on static assets alone. Users expect new content to be automatically posted; they expect to be able to leave comments; to perform searches and email links from within your application. None of these features seems to mesh with the static page generation described thus far. How can we have a CMS without these abilities? Luckily, we don't need to.

Here, client-side solutions will give us an easy path to recreating these features. We can include iframes or redirection to third-parties for Eventbright signups or Paypal processing. We can load JS from tools like Disqus and Wufoo to give us commenting and other types of forms. Ajax calls to other APIs allow us to recreate site-search, chat, and many of the other interactive features we expect from modern web applications. You did design your app API-first, right?

Ultimately, continuously updating content and user-triggered dynamism are not static sites' sweet spot. Finding the right balance between static and dynamic content will depend on each project. The latest wave in static site generators have simply made it easier to swing their way, so much so that I would strongly recommend their consideration in future projects. They are easier to maintain, simpler to understand, and more secure than Drupal, Wordpress, and their ilk; why not try it out?

## Resources

* Static Site Generators: [Jekyll](http://jekyllrb.com/) and [Nanoc](http://nanoc.ws/)
* [Github pages](http://pages.github.com/)
* Markdown editors: [Prose.io](http://prose.io) (a Github "cloud" editor), [Mou](http://mouapp.com/) for OSX
* 3rd party dynamic content: [Disqus](http://disqus.com/) for comments, [Wufoo](http://www.wufoo.com/) for forms, [Tapir](http://tapirgo.com/) for search, Twitter's [JS Library](https://dev.twitter.com/docs/tfw-javascript) for tweets
