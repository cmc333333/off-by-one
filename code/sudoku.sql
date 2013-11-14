CREATE TABLE cell_domain (v int);

INSERT INTO cell_domain VALUES (1); INSERT INTO cell_domain VALUES (2);
INSERT INTO cell_domain VALUES (3); INSERT INTO cell_domain VALUES (4);
INSERT INTO cell_domain VALUES (5); INSERT INTO cell_domain VALUES (6);
INSERT INTO cell_domain VALUES (7); INSERT INTO cell_domain VALUES (8);
INSERT INTO cell_domain VALUES (9);

CREATE TABLE sudokurow 
  (c1 int, c2 int, c3 int, c4 int, c5 int, c6 int, c7 int, c8 int, c9 int);

INSERT INTO sudokurow
  SELECT
  -- Each cell
  d1.v as c1, d2.v as c2, d3.v as c3, d4.v as c4, d5.v as c5, d6.v as c6, 
    d7.v as c7, d8.v as c8, d9.v as c9
  --  Each cell's table
  FROM 
    cell_domain as d1, cell_domain as d2, cell_domain as d3, cell_domain as d4,
    cell_domain as d5, cell_domain as d6, cell_domain as d7, cell_domain as d8,
    cell_domain as d9

  -- Each row cell must be distinct
  WHERE
    c1 <> c2 and c1 <> c3 and c1 <> c4 and c1 <> c5 and c1 <> c6 and c1 <> c7 
      and c1 <> c8 and c1 <> c9
    and c2 <> c3 and c2 <> c4 and c2 <> c5 and c2 <> c6 and c2 <> c7 
      and c2 <> c8 and c2 <> c9
    and c3 <> c4 and c3 <> c5 and c3 <> c6 and c3 <> c7 and c3 <> c8 
      and c3 <> c9
    and c4 <> c5 and c4 <> c6 and c4 <> c7 and c4 <> c8 and c4 <> c9
    and c5 <> c6 and c5 <> c7 and c5 <> c8 and c5 <> c9
    and c6 <> c7 and c6 <> c8 and c6 <> c9
    and c7 <> c8 and c7 <> c9
    and c8 <> c9
;

CREATE VIEW board AS
  SELECT 
  r1.c1 as c11, r1.c2 as c12, r1.c3 as c13, r1.c4 as c14, r1.c5 as c15,
    r1.c6 as c16, r1.c7 as c17, r1.c8 as c18, r1.c9 as c19,
  r2.c1 as c21, r2.c2 as c22, r2.c3 as c23, r2.c4 as c24, r2.c5 as c25,
    r2.c6 as c26, r2.c7 as c27, r2.c8 as c28, r2.c9 as c29,
  r3.c1 as c31, r3.c2 as c32, r3.c3 as c33, r3.c4 as c34, r3.c5 as c35,
    r3.c6 as c36, r3.c7 as c37, r3.c8 as c38, r3.c9 as c39,
  r4.c1 as c41, r4.c2 as c42, r4.c3 as c43, r4.c4 as c44, r4.c5 as c45,
    r4.c6 as c46, r4.c7 as c47, r4.c8 as c48, r4.c9 as c49,
  r5.c1 as c51, r5.c2 as c52, r5.c3 as c53, r5.c4 as c54, r5.c5 as c55,
    r5.c6 as c56, r5.c7 as c57, r5.c8 as c58, r5.c9 as c59,
  r6.c1 as c61, r6.c2 as c62, r6.c3 as c63, r6.c4 as c64, r6.c5 as c65,
    r6.c6 as c66, r6.c7 as c67, r6.c8 as c68, r6.c9 as c69,
  r7.c1 as c71, r7.c2 as c72, r7.c3 as c73, r7.c4 as c74, r7.c5 as c75,
    r7.c6 as c76, r7.c7 as c77, r7.c8 as c78, r7.c9 as c79,
  r8.c1 as c81, r8.c2 as c82, r8.c3 as c83, r8.c4 as c84, r8.c5 as c85,
    r8.c6 as c86, r8.c7 as c87, r8.c8 as c88, r8.c9 as c89,
  r9.c1 as c91, r9.c2 as c92, r9.c3 as c93, r9.c4 as c94, r9.c5 as c95,
    r9.c6 as c96, r9.c7 as c97, r9.c8 as c98, r9.c9 as c99

  --  Each cell's table
  FROM 
    sudokurow as r1, sudokurow as r2, sudokurow as r3,
      sudokurow as r4, sudokurow as r5, sudokurow as r6,
      sudokurow as r7, sudokurow as r8, sudokurow as r9

  WHERE
    -- Columns Are Distinct
    c11 <> c21 and c11 <> c31 and c11 <> c41 and c11 <> c51 and c11 <> c61
      and c11 <> c71 and c11 <> c81 and c11 <> c91
      and c21 <> c31 and c21 <> c41 and c21 <> c51 and c21 <> c61 
        and c21 <> c71 and c21 <> c81 and c21 <> c91
      and c31 <> c41 and c31 <> c51 and c31 <> c61 and c31 <> c71 
        and c31 <> c81 and c31 <> c91
      and c41 <> c51 and c41 <> c61 and c41 <> c71 and c41 <> c81 
        and c41 <> c91
      and c51 <> c61 and c51 <> c71 and c51 <> c81 and c51 <> c91
      and c61 <> c71 and c61 <> c81 and c61 <> c91
      and c71 <> c81 and c71 <> c91
      and c81 <> c91
    and c12 <> c22 and c12 <> c32 and c12 <> c42 and c12 <> c52 and c12 <> c62
      and c12 <> c72 and c12 <> c82 and c12 <> c92
      and c22 <> c32 and c22 <> c42 and c22 <> c52 and c22 <> c62 
        and c22 <> c72 and c22 <> c82 and c22 <> c92
      and c32 <> c42 and c32 <> c52 and c32 <> c62 and c32 <> c72 
        and c32 <> c82 and c32 <> c92
      and c42 <> c52 and c42 <> c62 and c42 <> c72 and c42 <> c82 
        and c42 <> c92
      and c52 <> c62 and c52 <> c72 and c52 <> c82 and c52 <> c92
      and c62 <> c72 and c62 <> c82 and c62 <> c92
      and c72 <> c82 and c72 <> c92
      and c82 <> c92
    and c13 <> c23 and c13 <> c33 and c13 <> c43 and c13 <> c53 and c13 <> c63
      and c13 <> c73 and c13 <> c83 and c13 <> c93
      and c23 <> c33 and c23 <> c43 and c23 <> c53 and c23 <> c63 
        and c23 <> c73 and c23 <> c83 and c23 <> c93
      and c33 <> c43 and c33 <> c53 and c33 <> c63 and c33 <> c73 
        and c33 <> c83 and c33 <> c93
      and c43 <> c53 and c43 <> c63 and c43 <> c73 and c43 <> c83 
        and c43 <> c93
      and c53 <> c63 and c53 <> c73 and c53 <> c83 and c53 <> c93
      and c63 <> c73 and c63 <> c83 and c63 <> c93
      and c73 <> c83 and c73 <> c93
      and c83 <> c93
    and c14 <> c24 and c14 <> c34 and c14 <> c44 and c14 <> c54 and c14 <> c64
      and c14 <> c74 and c14 <> c84 and c14 <> c94
      and c24 <> c34 and c24 <> c44 and c24 <> c54 and c24 <> c64 
        and c24 <> c74 and c24 <> c84 and c24 <> c94
      and c34 <> c44 and c34 <> c54 and c34 <> c64 and c34 <> c74 
        and c34 <> c84 and c34 <> c94
      and c44 <> c54 and c44 <> c64 and c44 <> c74 and c44 <> c84 
        and c44 <> c94
      and c54 <> c64 and c54 <> c74 and c54 <> c84 and c54 <> c94
      and c64 <> c74 and c64 <> c84 and c64 <> c94
      and c74 <> c84 and c74 <> c94
      and c84 <> c94
    and c15 <> c25 and c15 <> c35 and c15 <> c45 and c15 <> c55 and c15 <> c65
      and c15 <> c75 and c15 <> c85 and c15 <> c95
      and c25 <> c35 and c25 <> c45 and c25 <> c55 and c25 <> c65 
        and c25 <> c75 and c25 <> c85 and c25 <> c95
      and c35 <> c45 and c35 <> c55 and c35 <> c65 and c35 <> c75 
        and c35 <> c85 and c35 <> c95
      and c45 <> c55 and c45 <> c65 and c45 <> c75 and c45 <> c85 
        and c45 <> c95
      and c55 <> c65 and c55 <> c75 and c55 <> c85 and c55 <> c95
      and c65 <> c75 and c65 <> c85 and c65 <> c95
      and c75 <> c85 and c75 <> c95
      and c85 <> c95
    and c16 <> c26 and c16 <> c36 and c16 <> c46 and c16 <> c56 and c16 <> c66
      and c16 <> c76 and c16 <> c86 and c16 <> c96
      and c26 <> c36 and c26 <> c46 and c26 <> c56 and c26 <> c66 
        and c26 <> c76 and c26 <> c86 and c26 <> c96
      and c36 <> c46 and c36 <> c56 and c36 <> c66 and c36 <> c76 
        and c36 <> c86 and c36 <> c96
      and c46 <> c56 and c46 <> c66 and c46 <> c76 and c46 <> c86 
        and c46 <> c96
      and c56 <> c66 and c56 <> c76 and c56 <> c86 and c56 <> c96
      and c66 <> c76 and c66 <> c86 and c66 <> c96
      and c76 <> c86 and c76 <> c96
      and c86 <> c96
    and c17 <> c27 and c17 <> c37 and c17 <> c47 and c17 <> c57 and c17 <> c67
      and c17 <> c77 and c17 <> c87 and c17 <> c97
      and c27 <> c37 and c27 <> c47 and c27 <> c57 and c27 <> c67 
        and c27 <> c77 and c27 <> c87 and c27 <> c97
      and c37 <> c47 and c37 <> c57 and c37 <> c67 and c37 <> c77 
        and c37 <> c87 and c37 <> c97
      and c47 <> c57 and c47 <> c67 and c47 <> c77 and c47 <> c87 
        and c47 <> c97
      and c57 <> c67 and c57 <> c77 and c57 <> c87 and c57 <> c97
      and c67 <> c77 and c67 <> c87 and c67 <> c97
      and c77 <> c87 and c77 <> c97
      and c87 <> c97
    and c18 <> c28 and c18 <> c38 and c18 <> c48 and c18 <> c58 and c18 <> c68
      and c18 <> c78 and c18 <> c88 and c18 <> c98
      and c28 <> c38 and c28 <> c48 and c28 <> c58 and c28 <> c68 
        and c28 <> c78 and c28 <> c88 and c28 <> c98
      and c38 <> c48 and c38 <> c58 and c38 <> c68 and c38 <> c78 
        and c38 <> c88 and c38 <> c98
      and c48 <> c58 and c48 <> c68 and c48 <> c78 and c48 <> c88 
        and c48 <> c98
      and c58 <> c68 and c58 <> c78 and c58 <> c88 and c58 <> c98
      and c68 <> c78 and c68 <> c88 and c68 <> c98
      and c78 <> c88 and c78 <> c98
      and c88 <> c98
    and c19 <> c29 and c19 <> c39 and c19 <> c49 and c19 <> c59 and c19 <> c69
      and c19 <> c79 and c19 <> c89 and c19 <> c99
      and c29 <> c39 and c29 <> c49 and c29 <> c59 and c29 <> c69 
        and c29 <> c79 and c29 <> c89 and c29 <> c99
      and c39 <> c49 and c39 <> c59 and c39 <> c69 and c39 <> c79 
        and c39 <> c89 and c39 <> c99
      and c49 <> c59 and c49 <> c69 and c49 <> c79 and c49 <> c89 
        and c49 <> c99
      and c59 <> c69 and c59 <> c79 and c59 <> c89 and c59 <> c99
      and c69 <> c79 and c69 <> c89 and c69 <> c99
      and c79 <> c89 and c79 <> c99
      and c89 <> c99

    -- Sub Squares are distinct
    and c11 <> c22 and c11 <> c23 and c11 <> c32 and c11 <> c33
      and c12 <> c21 and c12 <> c23 and c12 <> c31 and c12 <> c33
      and c13 <> c21 and c13 <> c22 and c13 <> c31 and c13 <> c32
      and c21 <> c32 and c21 <> c33
      and c22 <> c31 and c22 <> c33
      and c23 <> c31 and c23 <> c32
    and c14 <> c25 and c14 <> c26 and c14 <> c35 and c14 <> c36
      and c15 <> c24 and c15 <> c26 and c15 <> c34 and c15 <> c36
      and c16 <> c24 and c16 <> c25 and c16 <> c34 and c16 <> c35
      and c24 <> c35 and c24 <> c36
      and c25 <> c34 and c25 <> c36
      and c26 <> c34 and c26 <> c35
    and c17 <> c28 and c17 <> c29 and c17 <> c38 and c17 <> c39
      and c18 <> c27 and c18 <> c29 and c18 <> c37 and c18 <> c39
      and c19 <> c27 and c19 <> c28 and c19 <> c37 and c19 <> c38
      and c27 <> c38 and c27 <> c39
      and c28 <> c37 and c28 <> c39
      and c29 <> c37 and c29 <> c38

    and c41 <> c52 and c41 <> c53 and c41 <> c62 and c41 <> c63
      and c42 <> c51 and c42 <> c53 and c42 <> c61 and c42 <> c63
      and c43 <> c51 and c43 <> c52 and c43 <> c61 and c43 <> c62
      and c51 <> c62 and c51 <> c63
      and c52 <> c61 and c52 <> c63
      and c53 <> c61 and c53 <> c62
    and c44 <> c55 and c44 <> c56 and c44 <> c65 and c44 <> c66
      and c45 <> c54 and c45 <> c56 and c45 <> c64 and c45 <> c66
      and c46 <> c54 and c46 <> c55 and c46 <> c64 and c46 <> c65
      and c54 <> c65 and c54 <> c66
      and c55 <> c64 and c55 <> c66
      and c56 <> c64 and c56 <> c65
    and c47 <> c58 and c47 <> c59 and c47 <> c68 and c47 <> c69
      and c48 <> c57 and c48 <> c59 and c48 <> c67 and c48 <> c69
      and c49 <> c57 and c49 <> c58 and c49 <> c67 and c49 <> c68
      and c57 <> c68 and c57 <> c69
      and c58 <> c67 and c58 <> c69
      and c59 <> c67 and c59 <> c68

    and c71 <> c82 and c71 <> c83 and c71 <> c92 and c71 <> c93
      and c72 <> c81 and c72 <> c83 and c72 <> c91 and c72 <> c93
      and c73 <> c81 and c73 <> c82 and c73 <> c91 and c73 <> c92
      and c81 <> c92 and c81 <> c93
      and c82 <> c91 and c82 <> c93
      and c83 <> c91 and c83 <> c92
    and c74 <> c85 and c74 <> c86 and c74 <> c95 and c74 <> c96
      and c75 <> c84 and c75 <> c86 and c75 <> c94 and c75 <> c96
      and c76 <> c84 and c76 <> c85 and c76 <> c94 and c76 <> c95
      and c84 <> c95 and c84 <> c96
      and c85 <> c94 and c85 <> c96
      and c86 <> c94 and c86 <> c95
    and c77 <> c88 and c77 <> c89 and c77 <> c98 and c77 <> c99
      and c78 <> c87 and c78 <> c89 and c78 <> c97 and c78 <> c99
      and c79 <> c87 and c79 <> c88 and c79 <> c97 and c79 <> c98
      and c87 <> c98 and c87 <> c99
      and c88 <> c97 and c88 <> c99
      and c89 <> c97 and c89 <> c98
;

CREATE VIEW pretty AS
  SELECT '', c11, c12, c13, c14, c15, c16, c17, c18, c19, x'0a',
             c21, c22, c23, c24, c25, c26, c27, c28, c29, x'0a',
             c31, c32, c33, c34, c35, c36, c37, c38, c39, x'0a',
             c41, c42, c43, c44, c45, c46, c47, c48, c49, x'0a',
             c51, c52, c53, c54, c55, c56, c57, c58, c59, x'0a',
             c61, c62, c63, c64, c65, c66, c67, c68, c69, x'0a',
             c71, c72, c73, c74, c75, c76, c77, c78, c79, x'0a',
             c81, c82, c83, c84, c85, c86, c87, c88, c89, x'0a',
             c91, c92, c93, c94, c95, c96, c97, c98, c99, x'0a'
  FROM board
;
