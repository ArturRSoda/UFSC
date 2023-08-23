printf("Questão 1.a:\n")
printf("n = -20.125\n")
x = questao1(-20.125);

printf("\n")

printf("Questão 1.b:\n")
printf("n = -60.06\n")
x = questao1(-60.06);

printf("\n")

printf("Questão 2.1.a)\n")
[A, B] = questao21();

printf("\n")

printf("Questão 2.1.b)\n")
[X, op] = questao21b(A, B)
residuo = double(sum((A*X) - B))

printf("\n")

printf("Questão 2.1.c)\n")
printf("numero de operacoes.: %d \n", op)


