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

from sys import argv, setprofile

def ler_argumentos(argv):
    split_input    = argv[1:-1].split(';')
    n_estados      = int(split_input[0])
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

    def to_string(self):
        return "<%d;{%s};{%s};{%s};%s>" % (
            self.qtd_estados,
            self.estado_inicial,
            ",".join(["{%s}" %ef for ef in sorted(self.estados_finais)]),
            ",".join(sorted(self.alfabeto)),
            ";".join([t for t in [';'.join(["{%s},%s,{%s}" % (qi, a, self.transicoes[qi][a]) for a in sorted(self.transicoes[qi].keys()) if (self.transicoes[qi][a])]) for qi in sorted(self.transicoes.keys())]])
        )


def determiniza(automato, estado, transicoes):
    transicoes[estado] = dict()
    for a in automato.alfabeto:
        qj = ''.join([automato.transicoes[qi][a] for qi in estado])
        transicoes[estado][a] = ''.join(sorted(set(qj)))

    for qj in transicoes[estado].values():
        if (qj not in transicoes):
            determiniza(automato, qj, transicoes)


def main():
    vpl_input = argv[1] # **Não remover essa linha**, ela é responsável por receber a string de entrada do VPL.

    """ 
        Seu código para resolver o exercício e printar a saída. 
        Você pode fazer funções foras da main se preferir. 
        Essa é apenas uma sugestão de estruturação.
        [...]
    """

    nao_deterministico = Automato(*ler_argumentos(vpl_input))
    print(nao_deterministico.qtd_estados)
    print(nao_deterministico.estados)
    print(nao_deterministico.alfabeto)
    print(nao_deterministico.transicoes)
    print(nao_deterministico.estado_inicial)
    print(nao_deterministico.estados_finais)
    print(nao_deterministico.to_string())

    print(nao_deterministico.aceita_transicao('P', '1', 'Q'))
    print(nao_deterministico.aceita_transicao('S', '1', 'S'))
    print()

    transicoes = {}
    determiniza(nao_deterministico, nao_deterministico.estado_inicial, transicoes)

    deterministico = Automato(
        len(transicoes.keys()),
        set(transicoes.keys()),
        nao_deterministico.alfabeto,
        transicoes,
        nao_deterministico.estado_inicial,
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



if __name__ == "__main__":
    main()
