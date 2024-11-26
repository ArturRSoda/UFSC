# GRUPO: - Artur Luiz Rizzato Toru Soda (22200349)
#        - Davi Menegaz Junkes (22200354)

from copy import deepcopy
from sys import argv

def parse_input(input):
    input_str = "".join(input)

    input = input_str.replace('"', '').replace(" ", "").replace("'", "").replace("{", "")
    N_str, T_str, S_str, P_str, entry = input.split('}')

    N = set(N_str.split(","))
    T = set(T_str.split(","))
    S = S_str

    P = dict()
    for n in N: P[n] = set()

    for t in P_str.split(";"):
        if ("=" in t):
            n, b = t.split("=")
            P[n].add(b)

    entry = entry.replace(";", "")

    return N, T, S, P, entry


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
                F[n] = F[n].union(fy-{"&"})

                if ("&" not in fy):
                    break
            else:
                F[n].add("&")

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

    productions = P[a]
    for prod in productions:
        l = len(prod)
        for i in range(l-1):
            b = prod[i]

            if (b in N):
                j = 1
                while (True):
                    if (i+j == l):
                        F[b] = F[b].union(F[a])
                        break

                    q = prod[i+j]
                    fq = First[q] if (q in N) else {q}

                    F[b] = F[b].union(fq-{'&'})

                    if ('&' in fq):
                        j += 1
                    else:
                        break

        b = prod[-1]
        if (b in N):
            F[b] = F[b].union(F[a])

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


def get_nullable(N, P):
    E = {"&"}
    while (True):
        Q = set()
        for x in N:
            if (x not in E):
                for prod in P[x]:
                    for symbol in prod:
                        if (symbol not in E):
                            break
                    else:
                        Q.add(x)

        E = E.union(Q)

        if (not Q):
            return E


def get_first_for_production(simb, first, T, P, nullables):
    for s in simb:
        if (s in T) or (s == "&"):
            first.add(s)
            return

        for prod in P[s]:
            get_first_for_production(prod, first, T, P, nullables)

        if (s not in nullables):
            return


def build_table(N, T, S, P, First, Follow):
    table = dict()
    for n in N:
        row = {'$' : None}
        for t in T:
            row[t] = None
        table[n] = row

    nullables = get_nullable(N, P)
    for n, productions in P.items():
        for prod in productions:
            first = set()
            get_first_for_production(prod, first, T, P, nullables)

            for f in first-{"&"}:
                table[n][f] = prod

            if ("&" in first):
                for f in Follow[n]:
                    table[n][f] = prod

    return table


def table_to_string(table):
    table_str = ""

    for n, T in table.items():
        for t in T:
            if (table[n][t]):
                table_str += "[%s,%s,%s]" % (n, t, table[n][t])

    return table_str


def process_entry(entry, S, table):
    stack = ['$', S]
    entry += '$'

    while (True):
        p = entry[0]
        q = stack[-1]

        if (p == q):
            if (p == '$'):
                break
            else:
                stack.pop()
                entry = entry[1:]
                continue

        prod = table[q][p]
        if (not prod):
            return False

        if (prod == '&'):
            stack.pop()
        else:
            prod = list(prod)
            stack = stack[:-1]
            while (prod):
                stack.append(prod.pop())
    return True


def main():
    vpl_input = argv[1:]

    N, T, S, P, entry = parse_input(vpl_input)

    First = search_firts(P)
    Follow = search_follows(S, First, P)

    table = build_table(N, T, S, P, First, Follow)

    accept = process_entry(entry, S, table)

    print("<{%s};%s;{%s,$};%s><%s>>" % (
        ",".join(N),
        S,
        ",".join(T),
        table_to_string(table),
        "sim" if accept else "nao"
    ))


if __name__ == "__main__":
    main()
