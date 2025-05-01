"""
Problema das 8 Rainhas:
Objetivo: Posicionar 8 rainhas em um tabuleiro 8x8 de forma que nenhuma rainha ataque outra (mesma linha, coluna ou diagonal).

Mapeamento para Algoritmo Genetico:
1. Representacao do Cromossomo:
   - Cada gene (indice) representa uma COLUNA do tabuleiro (0 a 7).
   - O valor do gene (0 a 7) representa a LINHA onde a rainha esta naquela coluna.
   - Exemplo: [3, 0, 4, 7, 1, 6, 2, 5] -> Rainhas nas casas: (0,3) (1,0) (2,4) (3,7) ...

3. Função Fitness:
   - Calcula pares de rainhas que nao se atacam (max = 28 pares).

4. Operadores Geneticos:
   - Cruzamento OX: Mantém permutações válidas.
   - Mutação por Troca: Preserva a estrutura de permutação.
"""

import pygad

def print_tabuleiro(solution):
    for i in range(8):
        linha = list()
        for j in range(8):
            if (solution[j] == i):
                linha.append('Q')
            else:
                linha.append('.')
        print(' '.join(linha))

# Verifica o numero de rainhas que nao se atacam (fitness maximo == 28)
def fitness_func(ga_instance, solution, solution_idx):
    fitness = 28

    # Verifica todos os pares
    for i in range(8):
        for j in range(i+1, 8):

            # Se estao na mesma linha ou na mesma diagonal -> diminui fitness
            if (solution[i] == solution[j]) or (abs(i - j) == abs(solution[i] - solution[j])):
                fitness -= 1

    return fitness


def main():
    ga_instance = pygad.GA(
        num_generations         = 1000,                                   # Numero de geracoes
        num_parents_mating      = 10,                                     # Numero de pais para cruzamento em cada geracao
        fitness_func            = fitness_func,                           # Funcao fitness
        sol_per_pop             = 50,                                     # Numero de solucoes por geracao
        num_genes               = 8,                                      # Numero de genes em cada solucao
        gene_space              = [{'low': 0, 'high': 8, 'step': 1}] * 8, # restringe os valores dos genes (0-7)
        mutation_type           = "random",                               # Tipo de mutacao ("random" -> cada gene tem uma probabilidade de ser trocado)
        mutation_probability    = 0.05,                                   # Probabilidade de um gene sofre mutacao
        mutation_num_genes      = 1,                                      # Numero de genes afetados por mutacao
        crossover_type          = "single_point",                         # funcao de cruzamento ("single_point" -> divide os cromossomos pais em um unico ponto e troca as partes subsequentes para gerar os filhos)
        parent_selection_type   = "tournament",                           # metodo de selecao de pais ("tournament" -> seleciona melhoers pais para manter)
        keep_parents            = 5,                                      # Numero de pais mantidos na proxima geracao
    )

    ga_instance.run()

    solution, solution_fitness, solution_idx = ga_instance.best_solution()
    ga_instance.plot_fitness()
    print(f"Parameters of the best solution : {solution}")
    print(f"Fitness value of the best solution = {solution_fitness}")
    print_tabuleiro(solution)


main()
