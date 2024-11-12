""" 
========= INSTRUÇÕES ========= 
    - Todo o código deve estar contido no arquivo main.py
    - O arquivo main.py deve conter uma função main que será chamada pelo VPL,
      essa função deve conter uma linha de código que recebe a string de entrada do VPL.
      Um exemplo de como isso pode ser feito está no arquivo main.py fornecido.
    - Você pode criar funções fora da main se preferir, mas se certifique de que a main chama essas funções.
    - Caso você prefira fazer o exercício em uma IDE e quiser testar o código localmente, 
    é só passar a string de entrada como argumento na hora de executar o código. 
        Exemplo: python3 main.py "P = KVC; K = cK; K = &; V = vV;"
"""

from copy import deepcopy
from sys import argv

def get_productions(input):
    input_str = ""
    for s in input:
        input_str += s

    input_str = input_str.replace(" ", "").replace('"', '')
    P_str = input_str.split(";")

    S = P_str[0][0]

    P = dict()
    for t in P_str:
        if ("=" in t):
            n, b = t.split("=")
            if (n not in P.keys()):
                P[n] = {b}
            else:
                P[n].add(b)

    return S, P


def get_first(n, F, P):

    if (n not in P.keys()):
        return {n}

    productions = P[n]
    for prod in productions:
        if (prod == "&"):
            F[n].add(prod)
        else:
            for y in prod:
                fy = get_first(y, F, P)
                F[n] = F[n].union(fy.copy()-{"&"})

                if ("&" not in fy):
                    break

    return F[n]


def search_firts(P):

    F = dict()
    for n in P.keys():
        F[n] = set()

    while (True):
        old_F = deepcopy(F)

        for n in P.keys():
            F[n] = get_first(n, F, P)

        if (F == old_F):
            break

    return F


def get_follow(a, F, S, First, P):
    N = P.keys()

    if (a == S):
        F[a].add('$')

    print("a -> ", a)
    productions = P[a]
    for prod in productions:
        print("    prod -> ", prod)
        l = len(prod)

        for i in range(l-1):
            b = prod[i]
            print("        b -> ", b)

            q = prod[i+1]
            fq = First[q] if (q in N) else {q}
            print("        q -> ", q)

            if (b in N):
                F[b] = F[b].union(fq-{'&'})
                print("            Added f%s in f%s" % (q, b))

                if ('&' in fq):
                    F[b] = F[b].union(F[a])
                    print("            Added f%s in f%s, cause & in f%s" % (a, b, q))


    return F[a]


def search_follows(S, First, P):

    F = dict()
    for n in P.keys():
        F[n] = set()

    while (True):
        old_F = deepcopy(F)

        for n in P.keys():
            F[n] = get_follow(n, F, S, First, P)

        if (F == old_F):
            break

    return F

def main():
    vpl_input = argv[1:] # **Não remover essa linha**, ela é responsável por receber a string de entrada do VPL

    """ 
        Seu código para resolver o exercício e printar a saída. 
        Você pode fazer funções foras da main se preferir. 
        Essa é apenas uma sugestão de estruturação.
        [...]
    """

    S, P = get_productions(vpl_input)
    print(S, P)
    print()

    First = search_firts(P)
    print(First)
    print()

    Follow = search_follows(S, First, P)
    print(Follow)

if __name__ == "__main__":
    main()
