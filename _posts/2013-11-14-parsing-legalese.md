---
layout: post
published: false
title: "Parsing Legalese: Rules for Rules"
---

One of the core contributions found in the recently released [eregs](http://eregs.github.io/eregulations) project is a plain-text parser for regulations, also known as rules. This parser pulls structure from the documents such that each paragraph can be properly index; it discoveres citations between the paragraphs and to external works; it determines definitions and even calculates differences between versions of the regulation. Due to the nature of the enterprise, we cannot leave room for probablistic methods employed via machine learning. Instead we retrieve all of the information through parsing, a rule-based approach to natural language processing.

## Regular Expressions: Regexi?

Regular expressions are one of the building blocks of almost any text parser. While we won't discuss them in great detail (there are many, better resources available,) I will note that learning how to write simple regexes doesn't take much time at all. As you progress and want to match more and more, Google around; do to their wide spread use, it's basically guaranteed that someone's had the same problem.

Regular expressions allow you to describe the "shape" of text you would like to match. For example, if a sentence has the the phrase "the term", followed by some text, followed by "means" we might assume that that sentence is defining a word or phrase. Regexes give us many tools to narrow down the shape of text, including special characters to indicate whitespace, the beginning and end of a line, and "word boundaries" like commas, spaces, etc.

```
"the term .* means"    # likely indicates a defined term
"\ba\b"                # only matches the word "a"
                       #   doesn't match "a" inside another word
```

Regexes also let us *retreive* text from matches

## Parser Combinators: Not Actually Scary

## What About Meaning?

## XML: So Much Structure, So Little Meaning