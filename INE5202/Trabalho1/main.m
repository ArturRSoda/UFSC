printf("Questão 1\n")
questao1()

printf("\n")

printf("Questão 2.1.a)\n")
[A, B] = questao21();

printf("\n")

printf("Questão 2.1.b)\n")
X = questao21b(A, B)
residuo = max(abs((A*X) - B))

printf("\n")

printf("Questão 2.1.c)\n")
N = size(X, 1);
Operacoes_realizadas = (4*(N**3) + 9*(N**2) - N - 6)/6

printf("\n")

printf("Questão 2.2.a)\n")
questao22a(A)

printf("\n")

printf("Questão 2.2.b)\n")
[X, Operacoes_realizadas] = questao22b(A, B);
X
residuo = max(abs((A*X) - B))

printf("\n")

printf("Questão 2.2.c)\n")
Operacoes_realizadas
