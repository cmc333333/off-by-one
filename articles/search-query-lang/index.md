---
title: In Search of a Query Language
layout: post
author: CM Lubinski
published: false
---

### Intro

### Exact Matches
As we will emphasize later, query languages are often compositions of other
queries. Perhaps the bedrock layer is generated from direct equality. In the
set of objects within our search space, are there any *exact* matches. For
example, consider the set of strings `{aaa, bbb, ccc}`. If we searches within
this set for an exact match of `ccc`, we would find the third element in the
set. Searching for `ddd` would have no exact hits. The use case for exact
matches, then, is to check if an element is present or not, to check its
existence. If our search space is a multi-set (where elements can be repeated,
as in most RDMSes), we might also want to count the number of exact matches in
the set.

### Slicing
While the number of use cases for exact matching is limited, generalizing the
comparison will give a great deal of flexibility. Consider the set
corresponding to the English vowels: `{a, e, i, o, u, y}`. If we wanted to
find all of the letters that came before `o`, we could combine the results of
an exact match on `a`, `e`, and `i`, but this is cumbersome. A better approach
would be to filter by the comparator `< o`. There's no reason to constrict
ourselves to elements of the set -- we could also filter by `< h`.

In addition to concision, these "slicing" queries are more expressive than
using multiple exact matches. Consider the infinite set of rational numbers
(effectively, any number that can be written as a decimal). We cannot express
a query that selects all entries less than `3` using an exact match approach.
Our query, which combines an exact match for `0`, `0.1`, `0.01`, `0.001`, etc.
would never complete.

Keeping within the scope of numbers, we can imagine other properties of
elements which we could use to slice the set. In a set of positive integers,
we might want to match only even numbers, or exclude primes. Whatever the
property, there are generally two mental models to represent the search.
In the first, we are checking each element in the set and "testing" whether or
not the property holds. The second approach would appear as a Venn diagram,
with one set representing all elements we are searching and the other all
elements conceivable that match our restriction (e.g. `< 3`). The intersection
is the elements in our set that also match the restriction.

### Properties of Strings
Text tends to encode meaning beyond its exact value. For example, the string
`color: burntOrange` might turn up if we wanted all strings which mention the
color orange. It might also appear if we were searching for key-value pairs or
instances of camel-case text. As strings are so flexible, we have build many
mechanisms for categorizing them. We have already discussed exact matches and
lexicographic-based comparators, but a natural next step would be to search
for substrings. Which elements in the set have `color` as a substring -- that
is, the string `color` is present, in its entirety, at *some* position within
the element.

An extension of the substring search is "glob" syntax, which allows us to
describe a specific search *pattern*. 

Glob, Regex, parser combinators?

### Structure Matching
sql, mongodb, css, xpath

### Induction
datalog, prolog, cp
