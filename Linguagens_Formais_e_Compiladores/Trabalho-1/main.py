""" 
========= INSTRUÇÕES ========= 
    - Todo o código deve estar contido no arquivo main.py
    - O arquivo main.py deve conter uma função main que será chamada pelo VPL,
      essa função deve conter uma linha de código que recebe a string de entrada do VPL.
      Um exemplo de como isso pode ser feito está no arquivo main.py fornecido.
    - Você pode criar funções fora da main se preferir, mas se certifique de que a main chama essas funções.
    - Caso você prefira fazer o exercício em uma IDE e quiser testar o código localmente, 
        é só passar a string de entrada como argumento na hora de executar o código. 
            Exemplo: python3 main.py "3;A;{C};{1,2,3,&};A,1,A;A,&,B;B,2,B;B,&,C;C,3,C"
        
Formato da saída:   <<automato finito determinístico><automato finito determinístico mínimo>>
                    <<3;{A};{D};{a,b};{A},a,{A};{A},a,{B};{A},b,{A};{B},b,{C};{C},b,{D}><3;{A};{D};{a,b};{A},a,{A};{A},a,{B};{A},b,{A};{B},b,{C};{C},b,{D}>>

DICA: O programa avalia somente o que está dentro das tags <>.
"""


from sys import argv

def ler_argumentos(input):
    split_input    = input.split(';')
    n_estados      = int(split_input[0]) if (split_input[0].isnumeric()) else 0
    estado_inicial = split_input[1]
    estados_finais = set(split_input[2][1:-1].split(','))
    alfabeto       = set(split_input[3][1:-1].split(','))
    transicoes_str = split_input[4:]
    estados        = set([estado for estados in [(transicao[0], transicao[4]) for transicao in transicoes_str] for estado in estados])

    transicoes = {estado:{a:'' for a in alfabeto} for estado in estados}
    for transicao in transicoes_str:
        qi, a, qj = transicao.split(',')
        transicoes[qi][a] += '%s'%qj

    return n_estados, estados, alfabeto, transicoes, estado_inicial, estados_finais


class Automato:
    def __init__(self, qtd_estados, estados, alfabeto, transicoes, estado_inicial, estados_finais):
        self.qtd_estados      = qtd_estados
        self.estados          = estados
        self.alfabeto         = alfabeto
        self.transicoes       = transicoes
        self.estado_inicial   = estado_inicial
        self.estados_finais   = estados_finais

    def aceita_transicao(self, qi, a, qj):
        return qj in self.transicoes[qi][a]

    def eh_final(self, q):
        return q in self.estados_finais

    def get_transicoes_maes(self, qj):
        return [t[0] for t in [[(qi, a) for a in sorted(self.alfabeto) if (self.transicoes[qi][a] == qj)] for qi in self.transicoes.keys()] if (t)]

    def get_e_fecho(self, q):
        fecho = set(q)
        if ('&' in self.alfabeto):
            qj = self.transicoes[q]['&']
            if (qj):
                qj_e_fecho = self.get_e_fecho(qj)
                fecho = fecho.union(qj_e_fecho)

        return fecho

    def to_string(self):
        return "<%d;{%s};{%s};{%s};%s>" % (
            self.qtd_estados,
            self.estado_inicial,
            ",".join(["{%s}" %ef for ef in sorted(self.estados_finais)]),
            ",".join(sorted(self.alfabeto)),
            ";".join([t for t in [';'.join(["{%s},%s,{%s}" % (qi, a, self.transicoes[qi][a]) for a in sorted(self.transicoes[qi].keys()) if (self.transicoes[qi][a])]) for qi in sorted(self.transicoes.keys())]])
        )


TESTE = Automato(
    8,
    {'A', 'B', 'C', 'E', 'F', 'G', 'H', 'I'},
    {'0', '1'},
    {
        'A': {'0': 'G', '1': 'B'},
        'B': {'0': 'F', '1': 'E'},
        'C': {'0': 'C', '1': 'G'},
        'E': {'0': 'E', '1': 'A'},
        'F': {'0': 'B', '1': 'C'},
        'G': {'0': 'H', '1': 'F'},
        'H': {'0': 'I', '1': 'H'},
        'I': {'0': 'H', '1': 'I'}
    },
    'A',
    {'G', 'A'}
)


TESTE2 = Automato(
    6,
    {'A', 'B', 'C', 'D', 'E', 'F'},
    {'0', '1'},
    {
        'A': {'0': 'D', '1': 'B'},
        'B': {'0': 'F', '1': 'E'},
        'C': {'0': 'C', '1': 'D'},
        'D': {'0': 'D', '1': 'F'},
        'E': {'0': 'E', '1': 'A'},
        'F': {'0': 'B', '1': 'C'},
    },
    'A',
    {'A', 'D'}
)

INPUT1 = "4;P;{S};{0,1};P,0,P;P,0,Q;P,1,P;Q,0,R;Q,1,R;R,0,S;S,0,S;S,1,S"
INPUT2 = "3;A;{C};{1,2,3,&};A,1,A;A,&,B;B,2,B;B,&,C;C,3,C"
INPUT3 = "4;A;{D};{a,b};A,a,A;A,a,B;A,b,A;B,b,C;C,b,D"
INPUT4 = "4;A;{A,D};{a,b};A,a,A;A,a,B;A,b,A;B,b,C;C,b,D"
INPUT5 = "6;S;{S,X};{a,b,c};S,a,A;S,b,A;S,b,C;S,c,C;A,a,M;A,b,B;A,b,X;A,c,D;A,c,X;B,a,A;B,b,A;B,b,C;B,c,C;C,a,E;C,a,X;C,b,B;c,b,X;C,c,M;D,a,A;D,b,A;D,b,C;D,c,M;E,a,M;E,b,A;E,b,C;E,c,C"



def determiniza_transicoes(automato, estado, transicoes):
    estado = ''.join(sorted(estado))

    transicoes[estado] = dict()
    for a in automato.alfabeto:
        if (a != '&'):
            qj = set()
            for qi in estado:
                t = automato.transicoes[qi][a]
                if (t):
                    f = ''.join(sorted(automato.get_e_fecho(t)))
                    qj.add(f)

            transicoes[estado][a] = ''.join(sorted(set(qj)))

    for qj in transicoes[estado].values():
        if (qj not in transicoes) and (qj!= ''):
            determiniza_transicoes(automato, qj, transicoes)


def remove_estados_mortos(automato, qj, alcansaveis):
    prox_qj = set()
    for q in qj:
        for (qi, a) in sorted(automato.get_transicoes_maes(q)):
            t = dict.fromkeys(automato.alfabeto, "")
            if (qi in sorted(alcansaveis.keys())):
                alcansaveis[qi][a] = q
            else:
                prox_qj.add(qi)
                t[a] = q
                alcansaveis[qi] = t

    if (prox_qj):
        remove_estados_mortos(automato, prox_qj, alcansaveis)


def define_classes(automato, classes):
    p = [s.copy() for s in classes]
    w = [s.copy() for s in classes]

    while (w):
        a = w.pop()
        for c in automato.alfabeto:
            x = set()
            for qi in automato.estados:
                qj = automato.transicoes[qi][c]
                if (qj in a):
                    x.add(qi)

            for y in p:
                intersec, diff = x.intersection(y), y.difference(x)
                if (not intersec) or (not diff):
                    continue

                p.remove(y)
                p += [intersec, diff]

                if y in w:
                    w.remove(y)
                    w += [intersec, diff]
                else:
                    w += [intersec] if (len(intersec) <= len(diff)) else [diff]

    return p

def monta_transicoes_minimas(automato, classes):
    transicao = dict()
    for classe in classes:
        qi = ''.join(sorted(set(''.join(classe))))
        transicao[qi] = dict()

        for a in sorted(automato.alfabeto):
            qj = set()
            for q in classe:
                qj.add(automato.transicoes[q][a])

            qj = ''.join(sorted(set(''.join(qj))))
            for classe_ in classes:
                if qj in classe_:
                    transicao[qi][a] = ''.join(sorted(set(''.join(classe_))))
                    break


    return transicao


def main():
    vpl_input = argv[1] # **Não remover essa linha**, ela é responsável por receber a string de entrada do VPL.

    """ 
        Seu código para resolver o exercício e printar a saída. 
        Você pode fazer funções foras da main se preferir. 
        Essa é apenas uma sugestão de estruturação.
        [...]
    """
    vpl_input = INPUT4
    
    nao_deterministico = Automato(*ler_argumentos(vpl_input))
    print(nao_deterministico.transicoes)

    print()
    print()

    transicoes = {}
    determiniza_transicoes(nao_deterministico, nao_deterministico.get_e_fecho(nao_deterministico.estado_inicial), transicoes)

    deterministico = Automato(
        len(transicoes.keys()),
        set(transicoes.keys()),
        nao_deterministico.alfabeto-{'&'},
        transicoes,
        ''.join(sorted(nao_deterministico.get_e_fecho(nao_deterministico.estado_inicial))),
        set([estado for estado in transicoes.keys() if (set(estado).intersection(nao_deterministico.estados_finais))])
    )
    print(deterministico.qtd_estados)
    print(deterministico.estados)
    print(deterministico.alfabeto)
    print(deterministico.transicoes)
    print(deterministico.estado_inicial)
    print(deterministico.estados_finais)
    print(deterministico.to_string())

    print()
    print()

    alcansaveis = {}
    remove_estados_mortos(deterministico, deterministico.estados_finais, alcansaveis)
    print(alcansaveis)
    print()
    print()

    deterministico_sem_morto = Automato(
        len(alcansaveis.keys()),
        set(alcansaveis.keys()),
        deterministico.alfabeto,
        alcansaveis,
        deterministico.estado_inicial,
        set([estado for estado in alcansaveis.keys() if (estado in deterministico.estados_finais)])
    )

    estados_minimos = define_classes(deterministico_sem_morto, [deterministico_sem_morto.estados_finais, deterministico_sem_morto.estados.difference(deterministico_sem_morto.estados_finais)])
    estados_minimos = [estado for estado in estados_minimos if (estado)]
    transicoes_minimas = monta_transicoes_minimas(deterministico_sem_morto, estados_minimos)

    print(estados_minimos)
    print(transicoes_minimas)
    print()
    print()

    deterministico_minimo = Automato(
        len(transicoes_minimas.keys()),
        set(transicoes_minimas.keys()),
        deterministico.alfabeto,
        transicoes_minimas,
        deterministico.estado_inicial,
        set([estado for estado in transicoes_minimas.keys() if (set(estado).intersection(nao_deterministico.estados_finais))])
    )

    print(deterministico_minimo.qtd_estados)
    print(deterministico_minimo.estados)
    print(deterministico_minimo.alfabeto)
    print(deterministico_minimo.transicoes)
    print(deterministico_minimo.estado_inicial)
    print(deterministico_minimo.estados_finais)
    print(deterministico_minimo.to_string())

    print()
    print()

    saida = "<%s%s>" % (deterministico.to_string(), deterministico_minimo.to_string())

    print(saida)

if __name__ == "__main__":
    main()
