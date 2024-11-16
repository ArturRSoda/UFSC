""" 
========= INSTRUÇÕES ========= 
    - Todo o código deve estar contido no arquivo main.py
    - O arquivo main.py deve conter uma função main que será chamada pelo VPL,
      essa função deve conter uma linha de código que recebe a string de entrada do VPL.
      Um exemplo de como isso pode ser feito está no arquivo main.py fornecido.
    - Você pode criar funções fora da main se preferir, mas se certifique de que a main chama essas funções.
    - Caso você prefira fazer o exercício em uma IDE e quiser testar o código localmente, 
    é só passar a string de entrada como argumento na hora de executar o código. 
        Exemplo: python3 main.py "{A,B,S}{a,b,c,d}{S}{S = Bd; S = &; B = Bc; B = b; B = Ab; A = Sa; A = a}"
"""


from sys import argv
from copy import deepcopy


class Grammar:
    def __init__(self, N, T, P, S):
        self.N = N
        self.T = T
        self.P = P
        self.S = S

    def to_str(self):
        N_str = ",".join(self.N)
        T_str = ",".join(self.T)

        P_lst = list()
        for n, productions in self.P.items():
            for b in productions:
                P_lst.append("%s = %s" % (n, b))
        P_str = "; ".join(P_lst)

        return "{%s}{%s}{%s}{%s}" % (N_str, T_str, self.S, P_str)


def get_parameters(input):
    input_str = ""
    for s in input:
        input_str += s

    input = input_str.replace('"', '').replace(" ", "").replace("{", "")
    N_str, T_str, S_str, P_str = input.split('}')[:-1]

    N = set(N_str.split(","))
    T = set(T_str.split(","))
    S = S_str

    P = dict()
    for n in N: P[n] = set()

    for t in P_str.split(";"):
        n, b = t.split("=")
        P[n].add(b)

    return N, T, S, P


def get_productions_symbols(prod):
    symbols = list()
    for p in prod:
        if (p == "'"):
            symbols[-1] += p
        else:
            symbols.append(p)

    return symbols


def remove_unproductive_symbols(G):
    SP = G.T.union({'&'})

    while (True):
        Q = set()
        for x in G.N:
            if (x not in SP):
                for prod in G.P[x]:
                    for p in get_productions_symbols(prod):
                        if (p not in SP):
                            break
                    else:
                        Q.add(x)

        SP = SP.union(Q)

        if (not Q):
            break

    N_ = SP.intersection(G.N)
    P_ = dict()
    if (G.S in SP):
        for a, productions in G.P.items():
            for prod in productions:
                for p in get_productions_symbols(prod):
                    if (p not in SP):
                        break
                else:
                    if (a not in P_.keys()):
                        P_[a] = {prod}
                    else:
                        P_[a].add(prod)

    return Grammar(N_, G.T, P_, G.S)


def remove_unreachable_symbols(G):
    SA = {G.S}

    while (True):
        M = set()

        for x in G.N.union(G.T):
            if (x not in SA):
                for y in SA:
                    if (y in G.N):
                        for prod in G.P[y]:
                            if (x in get_productions_symbols(prod)):
                                M.add(x)

        SA = SA.union(M)

        if (not M):
            break

    N_ = SA.intersection(G.N)
    T_ = SA.intersection(G.T)
    P_ = dict()
    for a, productions in G.P.items():
        for prod in productions:
            if (prod == "&"):
                if (a not in P_.keys()):
                    P_[a] = {prod}
                else:
                    P_[a].add(prod)
            else:
                for p in get_productions_symbols(prod):
                    if (p not in SA):
                        break
                else:
                    if (a not in P_.keys()):
                        P_[a] = {prod}
                    else:
                        P_[a].add(prod)

    return Grammar(N_, T_, P_, G.S)


def get_non_terminals_epsilon(G):
    E = {"&"}
    while (True):
        Q = set()
        for x in G.N:
            if (x not in E):
                for prod in G.P[x]:

                    for symbol in get_productions_symbols(prod):
                        if (symbol not in E):
                            break
                    else:
                        Q.add(x)

        E = E.union(Q)

        if (not Q):
            return E


def remove_non_terminal_epsilon(G):
    E = get_non_terminals_epsilon(G)

    P_l = dict()
    for n, productions in G.P.items():
        for prod in productions:
            if (prod != "&"):
                if (n not in P_l.keys()):
                    P_l[n] = {prod}
                else:
                    P_l[n].add(prod)

    while (True):
        to_add = list()

        for a, productions in P_l.items():
            for prod in productions:
                for i, b in enumerate(get_productions_symbols(prod)):
                    if (b in E):
                        p = prod[0:i] + prod[i+1:] 

                        for p_ in p:
                            if (p_ not in G.N.union(G.T)):
                                break
                        else:
                            if (p) and (p not in P_l[a]):
                                to_add.append((a, p))

        if (to_add):
            while (to_add):
                a, p = to_add.pop()
                P_l[a].add(p)
        else:
            break

    if (G.S in E):
        S_l = G.S + "'"
        P_l[S_l] = {G.S, "&"}
        N_l = G.N.union({S_l})
    else:
        S_l = G.S
        N_l = G.N

    return Grammar(N_l, G.T, P_l, S_l)


def remove_circular_productions(G):
    P_ = deepcopy(G.P)
    to_remove = list()
    for a, productions in P_.items():
        if (a in productions):
            to_remove.append(a)

    while (to_remove):
        a = to_remove.pop()
        P_[a].remove(a)

    return Grammar(G.N, G.T, P_, G.S)


def get_Na(G, visited, a):
    T = {a}

    for p in G.P[a]:
            if (p in G.N):
                if (p not in visited):
                    visited.append(p)
                    T = T.union(get_Na(G, visited, p))

    return T


def remove_unit_productions(G):
    N_a = dict()

    for a in G.N:
        N_a[a] = get_Na(G, [a], a)

    P_ = dict()
    for b, productions in G.P.items():
        for prod in productions:
            if (prod not in G.N):

                for a, pb in N_a.items():
                    if (b in pb):
                        if (a not in P_.keys()):
                            P_[a] = {prod}
                        else:
                            P_[a].add(prod)

    return Grammar(G.N, G.T, P_, G.S)


def order_non_terminals(G):
    A = [G.S]

    Q = [G.S]
    while (Q):
        a = Q.pop(0)
        for prod in G.P[a]:
            for p in get_productions_symbols(prod):
                if (p in G.N):
                    if (p not in A):
                        A.append(p)
                        Q.append(p)

    return A


def remove_direct_left_recursion(G):
    to_remove = list()
    to_add = list()
    for a, productions in G.P.items():
        for prod in productions:
            p0 = prod[0]
            if (p0 == a):
                a_ = a+"'"
                while (a_ in G.N):
                    a_ += "'"

                to_remove.append((a, prod))
                for prod_ in G.P[a]:
                    if (prod_[0] != a):
                        to_add.append((a, prod_+a_))
                        to_remove.append((a, prod_))

                to_add.append((a_, '&'))
                to_add.append((a_, prod[1:]+a_))

    P_ = deepcopy(G.P)
    N_ = deepcopy(G.N)
    while (to_remove):
        a, p = to_remove.pop()
        if (p in P_[a]):
            P_[a].remove(p)

    while (to_add):
        a, p = to_add.pop()
        if (a not in P_.keys()):
            P_[a] = {p}
            N_.add(a)
        else:
            P_[a].add(p)

    return Grammar(N_, G.T, P_, G.S)


def remove_left_recursion(G):
    A = order_non_terminals(G)

    for i in range(len(A)):
        to_remove = list()
        to_add = list()

        for j in range(len(A)):
            ai, aj = A[i], A[j]

            if (ai == aj):
                continue

            for prod in G.P[ai]:
                p0 = prod[0]
                if (aj == p0):
                    to_remove.append((ai, prod))

                    for prodj in G.P[aj]:
                        p0j = prodj[0]
                        if (p0j != aj):
                            to_add.append((ai, prodj+prod[1:]))

        P_ = deepcopy(G.P)
        while (to_remove):
            a, p = to_remove.pop()
            if (p in P_[a]):
                P_[a].remove(p)

        while (to_add):
            a, p = to_add.pop()
            if (a not in P_.keys()):
                P_[a] = {p}
            else:
                P_[a].add(p)

        G = remove_direct_left_recursion(Grammar(G.N, G.T, P_, G.S))

    return G


def main():

    vpl_input = argv[1:]

    """ 
    ========= INSTRUÇÕES ========= 
        - Todo o código deve estar contido no arquivo main.py
        - O arquivo main.py deve conter uma função main que será chamada pelo VPL,
        essa função deve conter uma linha de código que recebe a string de entrada do VPL.
        Um exemplo de como isso pode ser feito está no arquivo main.py fornecido.
        - Você pode criar funções fora da main se preferir, mas se certifique de que a main chama essas funções.
        - Caso você prefira fazer o exercício em uma IDE e quiser testar o código localmente, 
        é só passar a string de entrada como argumento na hora de executar o código. 
            Exemplo: python3 main.py "{A,B,S}{a,b,c,d}{S}{S = Bd; S = &; B = Bc; B = b; B = Ab; A = Sa; A = a}"
    """

    N, T, S, P = get_parameters(vpl_input)
    G = Grammar(N, T, P, S)

    G = remove_unproductive_symbols(G)

    G = remove_unreachable_symbols(G)

    G = remove_non_terminal_epsilon(G)

    G = remove_circular_productions(G)

    G = remove_unit_productions(G)

    G = remove_unreachable_symbols(G)
    s1 = G.to_str()

    G = remove_left_recursion(G)
    s2 = G.to_str()


    print("<<%s><%s>>" % (s1, s2))

if __name__ == "__main__":
    main()
