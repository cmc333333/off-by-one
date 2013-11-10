---
layout: post
title: Constraint Programming
---
A large part of our task as developers involves searching - or rather,
describing how the *computer* should be searching. In the worst situations,
we need to describe the search algorithm verbatim, perhaps implementing a
specialized binary search or walking along a social graph to find clusters
of friends. These tasks are much simpler when we can rely on query languages
like SQL, regular expressions and CSS selectors because we need only define
search "criteria" and we can let the search system choose the best
implementation. Constraint programming takes this improvement to an extreme,
requiring that users supply only a list of variables and a list of
constraints on those variables -- the constraint solver will go away to find
the solutions for you.

## Sudoku

Let's first consider the puzzle game, Sudoku. In its simplest form, this game
has a 9-by-9 grid serving as its board of play. The constraints on the board
are that each cell on the board must contain a number from 1 to 9, each cell
within a row must contain a different number, each cell within a column must
be likewise unique, and that each of the nine 3-by-3 sub-grids must also
contain distinct cell values. To make the game fun, several of the cells are
provided for the player, further constraining the game.

You can see how each of these specifications maps into one or more
constraints. We start with the board it self; each cell must be an integer
between 1 and 9:

```
array[1..9, 1..9] of var 1..9: board;
```

Next, we add constraints to represent limitations on rows and columns:

```
constraint forall (row in 1..9)
    (alldifferent (col in 1..9) (board[row, col]));
constraint forall (col in 1..9)
    (alldifferent (row in 1..9) (board[row, col]));
```

as well as the constraints for each subgrid containing distinct values. The
description below is overly explicit for clarity -- we could easily use for
loops to attain the same result.

```
constraint (
       alldifferent (row in 1..3, col in 1..3) (board[row, col])
    /\ alldifferent (row in 1..3, col in 4..6) (board[row, col])
    /\ alldifferent (row in 1..3, col in 7..9) (board[row, col])
    /\ alldifferent (row in 4..6, col in 1..3) (board[row, col])
    /\ alldifferent (row in 4..6, col in 4..6) (board[row, col])
    /\ alldifferent (row in 4..6, col in 7..9) (board[row, col])
    /\ alldifferent (row in 7..9, col in 1..3) (board[row, col])
    /\ alldifferent (row in 7..9, col in 4..6) (board[row, col])
    /\ alldifferent (row in 7..9, col in 7..9) (board[row, col])
);
```

Finally, we need to add a constraint for the grid's initial configuration,
i.e. the values which we were given:

```
constraint (
     board[1, 4] = 5 
  /\ board[2, 1] = 6 /\ board[2, 3] = 8 /\ board[2, 9] = 9
  /\ board[3, 2] = 4 /\ board[3, 4] = 3 /\ board[3, 8] = 1 /\ board[3, 9] = 2
  /\ board[4, 2] = 3 /\ board[4, 3] = 1 /\ board[4, 4] = 2
  /\ board[5, 4] = 6 /\ board[5, 5] = 1 /\ board[5, 6] = 7
  /\ board[6, 6] = 3 /\ board[6, 7] = 8 /\ board[6, 8] = 5
  /\ board[7, 1] = 3 /\ board[7, 2] = 7 /\ board[7, 6] = 4 /\ board[7, 8] = 6
  /\ board[8, 1] = 4 /\ board[8, 7] = 7 /\ board[8, 9] = 5
  /\ board[9, 6] = 2
);
```

The full example, including Minizinc requirements, solver, and output is
[available](sudoku.mzn), but this description should give you a sense of how
constraints are defined.

## Throwing Out the Chaff

If you spent any time on computer science theory, you will likely have come
across NP-hard problems, tasks which grow exponentially (or worse) with the
size of their input. Unfortunately, these problems are remarkably common "in
the wild". You may need to make the best schedule for a shared resource,
find the minumum required changes between two documents, or even just solve
a problem like the sudoku game above. Variants of each are NP-hard, so
simply checking each possible answer and picking the best is not feasible
for large input.

Luckily, we don't always need to check all possible solutions to find the
best. Many choices of numbers in sudoku, for example, produce an invalid
configuration - where the numbers in each square, column, or row are not
distinct. Programming with constraints means limiting the search space to
only those solutions which are valid.  For example, if we are scheduling
appointments and we know someone is on vacation on a particular day, there
is no point testing solutions that involve scheduling that person on that
day.

Note that the solution is still both *correct* and *optimal*. We only save
effort (and therefore time) by throwing out invalid configurations, not by
throwing out valid solutions. If we do not provide enough constraints, the
search space will remain incalculably large. The more constraints we
describe, the less work needs to be performed, and the faster we can find a
solution. You can also imagine how, if we restricted our search space
*beyond* the problem's requirements, we could find sub-optimal solutions
more quickly.

## A Better Search

Constraint programming environments and libraries provide more than just a
good metaphore for limiting the search space, however. They generally also
provide very efficient engines for searching the possibility space. Consider
our sudoku game; the range of possible values each cell can take depends on
the cells which are already known in the same row, column, and square.
Knowing the range of potential values for a cell in turn provides additional
constraints on the others. For example, if all cells in a row except one
have ranges which exclude the number 8, we can be certain that that
exception cell holds the number 8, regardless of what other values were in
its range. The back and forth while adjusting value ranges is known as
"propagation"

After enough propagation, the system will realize that it cannot trim the
search space down any further. For example, if there are more than one edit
that could be made to turn a word into another, eventually the program will
need to guess. The guess then triggers a new round of propation. It will
keep track of each "decision" so that it can unwind the sequence of
decisions it took and try slight different ones, always seeking an optimum.
Decisions may ultimately lead to an invalid or "failed" configuration, which
indicates when to unwind the decision stack, and certain search strategies
(e.g. binary search) may "guess" in a more efficient order.

## Add Zinc to Your Diet

My go-to tool for constraint programming is the Zinc suite. Minizinc is an
open source, high-level language for describing constrained problems such
that they can be solved by multiple solvers. The sudoku example above was
written in Minizinc. Minizinc files get compiled into Flatzinc, which is
then fed into any of a large number of compppatible solvers. Downloading
Minizinc gives you access to the Flatzinc compiler directly, but also
provides wrapper scripts to compile and then execute within a single
command.

To use Minizinc within your application, you will most likely need your
application to write a Minizinc source file. Your app can then shell out to
one of the single-shot compiler/executors and read the results - you will
most likely be able to read the output as JSON. This approach is
particularly appealing during development, when having direct access to the
minizinc input files and compilers will make debugging simpler. For a
production app, you will most likely want to switch over to a lower level
library (such as Gecode) for the performance improvement, but Minizinc is
great for development and learning constraint programming basics.

## Resources

* Minizinc and its tutorial
* Coursera class
* Gecode
* Libraries
