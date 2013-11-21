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

Regexes also let us *retrieve* matching text. In our example above, we could determine not only that a defined term was likely present but also what that term or phrase would be. Expressions may include multiple segments of retrieved text (known as "capture groups",) and advanced tools will provide deeper inspection such as segmenting out repeated expressions.

```
"Appendix ([A-Z]\d*) to Part (\d+)"
# Allows us to retrieve 'A6' and '2345' from
# "Appendix A6 to Part 2345"
```

Regular expressions serve as both a low-ish level tool for parsing and as a building block on which almost all parsing libraries will build. Understanding them will help you debug problems with higher-level tools as well as know their fundamental limitations.

## Parser Combinators: Not As Scary As They Sound

Regular expressions certainly require additional mental overhead by future developers, as they must generally "run" the expression in their head to see what it does. Well-named expressions help a bit, but the syntax for naming capture groups in generally quite ugly. Further, combining expressions is error-prone and leads to even more indecipherable code.

So-called "parser combinators" (i.e. parsers that can be combined) resolve or at least alleviate both of these issues. Combinators allow expressions to be named and easily combined to build larger expressions. The examples demonstrate these features using `pyparsing`, a parser combinator library for Python.

```
part = Word(digits).setResultsName("part")
section = Word(digits).setResultsName("section")
part_section = part + "." + section

parsed = part_section.parseString("1234.56")
assert(parsed.part == "1234")
assert(parsed.section == "56")
```

Parser combinators allow us to match relatively sophisticated citations, such as phrases which include multiple references separated by conjunction text. The parameter `listAllMatches` tells pyparsing to "collect" all the phrases which match

## What About Meaning?

## XML: So Much Structure, So Little Meaning