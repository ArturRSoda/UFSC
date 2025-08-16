:- initialization(main).

areaTriangulo(B, A, Area) :- Area is (B*A)/2.

main :- read(A),
        read(B),
        areaTriangulo(A, B, Area),
        writeln(Area),
        halt.
