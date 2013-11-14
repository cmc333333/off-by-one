---
layout: post
title: "SQL Sudoku: Constraint Programming"
published: true
---

Consider the game of Sudoku, most commonly played on a nine-by-nine grid of cells, where each cell may contain one of the integers 1 through 9. The game stipulates that each row must contain only unique elements, as must each column, and each of the nine, three-by-three sub-boards. Individual games are played with some cells on the board initially occupied, leaving the player to deduce the remaining values.

We can actually be more specific than "deduce"; when we play we are most likely *reducing* the number of options each cell may take. We realize that each rule - that rows contain distinct values, etc. - *constrains* the values of the cells it affects. Winning the game equates to finding a set of cell values that violates none of those rules. Shouldn't it be possible for us to simply define the rules and have the computer do the searching? Surely it will implement something more efficient than any strategy we would use.

This is the promise of constraint programming (a type of declarative programming.) To introduce it further, let's look at one of the more common implementations: SQL.

## SQL Sudoku

By implementing Sudoku in SQL, we will see some of the high-level concepts that reappear throughout constraint programming. We will also encounter several pain-points with our SQL implementation which we can smooth-over by using a more general-purpose language, like Minizinc (introduced later.)

Let's start by creating a domain for each cell; this is the set of all possible values an arbitrary cell could contain (1-9).

```
CREATE TABLE cell_domain (v int);

INSERT INTO cell_domain VALUES (1); INSERT INTO cell_domain VALUES (2);
INSERT INTO cell_domain VALUES (3); INSERT INTO cell_domain VALUES (4);
INSERT INTO cell_domain VALUES (5); INSERT INTO cell_domain VALUES (6);
INSERT INTO cell_domain VALUES (7); INSERT INTO cell_domain VALUES (8);
INSERT INTO cell_domain VALUES (9);
```

A row consists of nine of these values such that each cell's value is different. I couldn't think of a way to encode these required differences more elegantly than comparing each pair of values (a verbosity problem we'll run into again shortly.) As with cells, we're defining the *domain* of a sudoku row. Each SQL entry represents one possible sudoku row.

```
CREATE TABLE sudokurow 
  (c1 int, c2 int, c3 int, c4 int, c5 int, c6 int, c7 int, c8 int, c9 int);

INSERT INTO sudokurow
  SELECT d1.v as c1, d2.v as c2, ... d9.v as c9    -- Each cell
  FROM cell_domain as d1, cell_domain as d2, ...
  WHERE
    c1 <> c2 and c1 <> c3 and ...                  -- c1 is distinct
    and c2 <> c3 and c2 <> c4 and ...              -- c2 is distinct
    ...
    and c8 <> c9                                   -- c8 and c9 are distinct
;
```

Now that we have rows, we can implement a representation of the sudoku board. As there are far too many possible sudoku boards (i.e. the domain is too large) to materialize, we'll use an SQL view to represent the sudoku board's domain. Again, we'll have pair-wise distinction, which means a ***lot*** of inequalities.

```
CREATE VIEW board AS
  SELECT
  r1.c1 as c11, r1.c2 as c12, ...
  ... r9.c8 as c98, r9.c9 as c99
  FROM
    sudokurow as r1, sudokurow as r2, ...
  WHERE
    -- Distinct Column Values
    c11 <> c21 and c11 <> c31 ...
        and c21 <> c31 and c21 <> c41 ...
    ...
    c19 <> c29 and c19 <> c39 ...
        and c29 <> c39 and c29 <> c49 ...
    
    -- Distinct Sub-squares Values (all nine)
    and c11 <> c22 and c11 <> c23 ...
    ...
;
```

Solving for a particular sudoku board becomes as simple as running a select query with the initial configuration in the "where" clause:

```
SELECT * FROM board WHERE c11 = 1 and c22 = 2 and ...;
```

## Add Zinc to Your Diet

My go-to tool for constraint programming is the Zinc suite. Minizinc is an
open source, high-level language for describing constrained problems; its source files get compiled into a neutral (but lower-level) language called Flatzinc. Flatzinc files can then be read and solved by one of many constraint-solvers, as there are many potential search implementations. To make an analogy, Minizinc is the source code, Flatzinc is the virtual-machine byte-code, and the solvers are the operating-system-specific runtime environments.

Let's see how sudoku fits into Minizinc. We begin with a sudoku board, which consists of 9x9 cells each varying between the integers 1 and 9.

```
array[1..9, 1..9] of var 1..9: board;
```

Next, we add constraints to represent limitations on rows and columns. Note how much cleaner this is than the SQL implementation.

```
constraint forall (row in 1..9)
    (alldifferent (col in 1..9) (board[row, col]));
constraint forall (col in 1..9)
    (alldifferent (row in 1..9) (board[row, col]));
```

We also add constraints for each subgrid containing distinct values. The description below is overly explicit for clarity -- we could easily use for loops to attain the same result.

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

Finally, we need to add a constraint for the grid's initial configuration, i.e. the values which we were given:

```
constraint (
     board[1, 1] = 1 /\ board[2, 2] = 2 /\ ... 
);
```

## Throwing Out the Chaff

If you spent any time on computer science theory, you will likely have come across NP-hard problems, tasks which grow exponentially (or worse) with the size of their input. Unfortunately, these problems are remarkably common "in the wild". You may need to make the best schedule for a shared resource, find the minumum required changes between two documents, or even just solve a problem like the sudoku game above. Variants of each are NP-hard, so simply checking each possible answer and picking the best is not feasible for large input.

Luckily, we don't always need to check all possible solutions to find the best. Many choices of boards in sudoku, for example, produce an invalid configuration - where the numbers in each square, column, or row are not distinct. Programming with constraints means limiting the search space to only those solutions which are valid, significantly reducing the running time.

Constraint programming environments and libraries provide more than just a good metaphor for limiting the search space, however. They generally also provide very efficient engines for searching that possibility space. Consider our sudoku game; the range of possible values each cell can take depends on the cells which are already known in the same row, column, and square. Knowing the range of potential values for a cell in turn provides additional constraints on the others. For example, if all cells in a row except one have ranges which exclude the number 8, we can be certain that that exception cell holds the number 8, regardless of what other values were in its range. The back and forth while adjusting value ranges is known as "propagation."

After enough propagation, the system will realize that it cannot trim the search space down any further, and the program will need to guess. The guess then triggers a new round of propagation. It will keep track of each "decision" so that it can unwind the sequence of guesses it took and try different ones, always seeking an optimum. Decisions may ultimately lead to an invalid or "failed" configuration, which indicates when to unwind the decision stack, and certain search strategies (e.g. binary search) may "guess" in a more efficient order.

Note that the solutions are both *correct* and *optimal*. We only save effort (and therefore time) by throwing out invalid configurations, not by throwing out valid solutions. If we do not provide enough constraints, the search space will remain incalculably large. The more constraints we describe, the less work needs to be performed, and the faster we can find a solution. You can also imagine how, if we restricted our search space to be *tighter* than the problem's requirements, we could find sub-optimal solutions quickly.

## Implementation Notes

To use Minizinc within your application, you will most likely need your app to write a Minizinc source file. It can then shell out to one of the single-shot compiler/executors and read the results, which generally read as JSON. This approach is particularly appealing during development, when having direct access to the minizinc input files and compilers will make debugging simpler. For a production app, you may want to switch over to a lower level library (such as Gecode) for the performance improvement, but Minizinc is great for development and learning constraint programming basics. There's actually a Gecode implementation of Flatzinc, meaning you will only suffer the compilation hit.

## Resources

* SQL Sudoku [Initialization Script](../code/sudoku.sql)
* Full Minizinc Sudoku [Script](../code/sudoku.mzn)
* Minizinc: [site](http://www.minizinc.org/), [tutorial](http://www.minizinc.org/downloads/doc-latest/minizinc-tute.pdf)
* Coursera's [Discrete Optimization](https://www.coursera.org/course/optimization) course (from Pascal Van Hentenryck)
* Gecode's [flatzinc plugin](http://www.gecode.org/flatzinc.html)