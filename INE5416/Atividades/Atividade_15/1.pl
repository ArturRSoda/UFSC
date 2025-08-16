genitor(pam, bob).
genitor(tom, bob).
genitor(tom, liz).
genitor(bob, ana).
genitor(bob, pat).
genitor(liz,bill).
genitor(pat, jim).

mulher(pam).
mulher(liz).
mulher(pat).
mulher(ana).

homem(tom).
homem(bob).
homem(jim).
homem(bill).

pai(X,Y) :- genitor(X,Y), homem(X).
mae(X,Y) :- genitor(X,Y), mulher(X).

avo(AvoX, X) :- genitor(GenitorX, X), genitor(AvoX, GenitorX), homem(AvoX).
avoh(AvohX, X) :- genitor(GenitorX, X), genitor(AvohX, GenitorX), mulher(AvohX).

irmao(X,Y) :- genitor(PaiAmbos, X), genitor(PaiAmbos, Y), X \== Y, homem(X).
irma(X,Y) :- genitor(PaiAmbos, X), genitor(PaiAmbos, Y), X \== Y, mulher(X).
irmaos(X,Y) :- (irmao(X,Y); irma(X,Y)), X \== Y.

tio(X, Y) :- genitor(PaiouMae, Y), irmao(X, PaiouMae).
tia(X, Y) :- genitor(PaiouMae, Y), irma(X, PaiouMae).

primo(X, Y) :- genitor(TiaouTio, X), (tio(TiaouTio, Y); tia(TiaouTio, Y)), homem(X).
primo(X, Y) :- genitor(TiaouTio, X), (tio(TiaouTio, Y); tia(TiaouTio, Y)), mulher(X).

bisavo(X, Y) :- avo(X, PaiMae), genitor(PaiMae, Y).
bisavoh(X, Y) :- avoh(X, PaiMae), genitor(PaiMae, Y).

ascendente(X,Y) :- genitor(X,Y). %recursão - caso base
ascendente(X,Y) :- genitor(X, Z), ascendente(Z, Y). %recursão - passo recursivo

descendente(X, Y) :- ascendente(Y, X).

feliz(X) :- genitor(X, Y), descendente(Y, X).
