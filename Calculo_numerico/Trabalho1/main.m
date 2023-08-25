printf("Questão 1.a:\n")
printf("n = -20.125\n")
questao1(-20.125);

printf("\n")

printf("Questão 1.b:\n")
printf("n = -60.06\n")
questao1(-60.06);

printf("\n")

printf("Questão 2.1.a)\n")
[A, B] = questao21();

printf("Questão 2.1.b)\n")
X = questao21b(A, B)
residuo = sum((A*X) - B)

printf("\n")

printf("Questão 2.1.c)\n")
N = size(X, 1);
Operacoes_realizadas = (4*(N**3) + 9*(N**2) - N - 6)/6

printf("\n")

printf("Questão 2.1.a)\n")
questao22a(A)
printf("CONVERGE POR METODO ITERATIVO, pois o modulo de cada elemento da diagonal principal é maior ou igual a soma dos modulos dos demais elementos da respectiva linha. \n")




