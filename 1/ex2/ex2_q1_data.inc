.data
Bvec BYTE 0FFh, 0FEH, 10, 3
Wvec SWORD -5, -54, 100, 3000
Dvec SDWORD -500, 200, 300, 3000000
SumVec SDWORD lengthOf Bvec DUP (?)
msg1 BYTE "Sum Vector is:", 10, 13, 0