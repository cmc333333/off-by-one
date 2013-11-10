---
published: true
---

# Static CMSes

Despite the recent resurgence in enthusiasm in the database space, there is
a growing segment of developers who argue that dynamically generated content
is overkill for most web sites. Individual blogs, brochure websites, and
other content publishing sites are incredibly read heavy, and their content
changes very infrequently. Worse, modern CMSes require constant vigilance with regards to patching as new vulnerabilities are found each day.

Statically generated sites solve or alleviate many of these problems and add
some noteworthy additions. Instead of fetching content with each page
request, they need it only once, at compile time. Pages are most often
generated as flat HTML files -- there are no logins, no public-facing cgi scripts, and no need for application hardening. Versioning of your content
becomes trivial as both the content files and their generated output can
live in version control. As a cherry on top, removing the need for a server-side scripting language will not only improve page load times, it will also
reduce hosting prices. GitHub hosts thousands of static sites free of
charge.

## Content

Traditional CMSes store their data structures within a relational database;
these models can be created and edited through a web interface, which must
therefore be protected. While static CMSes *could* use a similar approach,
more often you will find content saved in flat files on the disk.  For
blogs, this might mean a series of markdown files with predictable file
names. For a brochure site, the content might be directly or partially saved
as HTML files. The content is automatically wrapped in consistent layouts as we would see in any other CMS.

It would be a large step back if we were only limited to markup, but luckily
structured data is also alive and well on static sites. Most generators
allow resources to include (or be entirely composed of) YAML-based
attributes. YAML, a superset of JSON, allows you at create ad hoc data
structures. Here, the file system is little different than a key-value
document store. If you consistently add attributes like "tags", "author",
"published", you can use them when generating a template (as you would with
any other CMS).

As static site generators are basically just scripts, they can also be
extended to allow additional data sources. Use a MySQL driver to query a
database when generating content. Connect to an API to download the latest
data as of the time the site is generated. Really, anything that you could
imagine happening on a traditional CMS can happen during the static site
generation phase.

## Jekyll and Nanoc

Jekyll is the most popular static site generator available in no small part
due to GitHub. The massively popular code sharing site allows for static
content via a stripped down Jekyll; search for "gh-pages" for a how-to. At
first glance, Jekyll is tailor made for publishing blogs, offering easy
setup for content with publication dates, authors, tags, etc. The software also allows static html pages and generic, YAML "data", which can be accessed through ERB templates. It can also be extended with plugins
to execute arbitrary Ruby code, though that's not possible for GitHub's
automatic site generation.

An alternative which I've grown to prefer is Nanoc, which is also written in
Ruby. Unlike Jekyll's blog-focused style, Nanoc processes content
abstractly, mirroring a traditional CMS. Categorize content by adding a
"type" field as a string (or list of strings); alternatively, use duck
typing to filter content to only those that have certain fields. Nanoc
content generally matches Jekyll's YAML meta data plus Markdown body, but it
also allows for YAML-only content, and content that can be generated (e.g.
from SQL). This tool is a wee bit more advanced than Jekyll, but certainly
clicks better for my programmer mind, and feels much more flexible. 

## Dynamism

Many sites cannot rely on static assets alone. Users expect new content to be automatically posted; they expect to be able to leave contents; they expect to perform searches and email links from within your application. None of these features seems to mesh with the static page generation described thusfar. How can we have a CMS without these abilities? Luckily, you don't need to.

Here, client-side Javascript will give us an easy path to recreating these features. Including JS from tools like Disqus and Wufoo give you commenting and other types of forms. Ajax calls to APIs allow you to recreate site-search, chat, and many of the other interactive features we expect from modern sites.

## Resources

* Jekyll and Nanoc
* Github pages