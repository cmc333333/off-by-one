include "globals.mzn";

array [1..9, 1..9] of var 1..9: board;

constraint forall (row in 1..9)
    (alldifferent (col in 1..9) (board[row, col]));
constraint forall (col in 1..9)
    (alldifferent (row in 1..9) (board[row, col]));

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

solve satisfy;
output[ show(board) ];
