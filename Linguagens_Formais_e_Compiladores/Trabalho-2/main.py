""" 
========= INSTRUÇÕES ========= 
    - Todo o código deve estar contido no arquivo main.py
    - O arquivo main.py deve conter uma função main que será chamada pelo VPL,
      essa função deve conter uma linha de código que recebe a string de entrada do VPL.
      Um exemplo de como isso pode ser feito está no arquivo main.py fornecido.
    - Você pode criar funções fora da main se preferir, mas se certifique de que a main chama essas funções.
    - Caso você prefira fazer o exercício em uma IDE e quiser testar o código localmente, 
    é só passar a string de entrada como argumento na hora de executar o código. 
        Exemplo: python3 main.py "<(&|b)(ab)*(&|a)><&|b|a|bb*a>"
"""

from sys import argv
from copy import deepcopy

def get_exp(input):
    exp1 = ""
    exp2 = ""
    input = list(input)

    flag = False
    input.pop(0)

    while (input):
        s = input.pop(0)

        if (s in ("<", ">")):
            flag = True
            continue

        if (not flag):
            exp1 += s
        else:
            exp2 += s

    return exp1, exp2


def add_concat(exp):
    exp = list(exp)
    prev_s = exp[0] 

    exp_concat = [prev_s]
    for s in exp[1:]:
        if (prev_s in "&ab*)"):
            if (s in "&ab("):
                exp_concat.append(".")

        exp_concat.append(s)
        prev_s = s

    return "(" + "".join(exp_concat) + ").#"


def greater_precedence(a, b):
    if   (a == "|"): return False
    elif (a == "."): return True if (b == "|") else False
    elif (a == "*"): return True


def shunting_yard(exp):
    exp = list(exp)
    output = list()
    operators = list()

    while (exp):
        s = exp.pop(0)

        if (s in "#&ab"):
            output.append(s)

        elif (s in "*|."):
            while (operators):
                op = operators[-1]

                if (greater_precedence(op, s)):
                    output.append(operators.pop())
                else:
                    break
            operators.append(s)

        elif (s == "("):
            operators.append(s)

        elif (s == ")"):
            while (operators):
                op = operators.pop()

                if (op == "("):
                    break
                else:
                    output.append(op)

    while (operators):
        output.append(operators.pop())

    return output

class Node:
    def __init__(self, s, id, right, left, nullable, fpos, lpos):
        self.s = s
        self.id = id
        self.r = right
        self.l = left
        self.nullable = nullable
        self.fpos = fpos
        self.lpos = lpos

    def print_nodes(self):
        if (self.l is not None) and (self.r is not None):
            print(self.s, self.r.s, self.l.s, self.nullable, self.fpos, self.lpos)
            print()
            self.r.print_nodes()
            self.l.print_nodes()
        else:
            print(self.s, "None None", self.id)
            print()


COUNTER = 0
FOLLOW_DICT = dict()
def build_syntax_tree(queue):
    global COUNTER, FOLLOW_DICT

    s = queue.pop()

    if (s in "ab&#"):
        if (s == "&"):
            nullable = True
            pos = set()
        else:
            COUNTER += 1
            nullable = False
            pos = set([COUNTER])
            FOLLOW_DICT[COUNTER] = (s, set())

        return Node(s, COUNTER, None, None, nullable, pos, pos)

    if (s == "*"):
        n = build_syntax_tree(queue)
        for sl in n.lpos:
            for sf in n.fpos:
                FOLLOW_DICT[sl][1].add(sf)
        return Node(s, None, n, n, True, n.fpos, n.lpos)

    if (s in "|."):
        r = build_syntax_tree(queue)
        l = build_syntax_tree(queue)

        if (s == "|"):
            nullable = r.nullable or l.nullable
            fpos = r.fpos.union(l.fpos)
            lpos = r.lpos.union(l.lpos)
        else:
            nullable = r.nullable and l.nullable

            fpos = l.fpos.union(r.fpos) if (l.nullable) else l.fpos
            lpos = r.lpos.union(l.lpos) if (r.nullable) else r.lpos

            if (r.s != "&") and (l.s != "&"):
                for sl in l.lpos:
                    for sf in r.fpos:
                        FOLLOW_DICT[sl][1].add(sf)

        return Node(s, None, r, l, nullable, fpos, lpos)


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
        initial_state = ",".join([str(ord(x)) for x in sorted(self.estado_inicial)])
        final_states = ",".join(["{%s}" % ",".join([str(ord(x)) for x in state]) for state in sorted(self.estados_finais)])
        alphabet = ",".join([a for a in sorted(self.alfabeto)])

        transitions = list()
        for qi in sorted(self.transicoes.keys()):
            for a in (sorted(self.transicoes[qi].keys())):
                if (self.transicoes[qi][a]):
                    qi_ = ",".join([str(ord(x)) for x in qi])
                    qj_ = ",".join([str(ord(x)) for x in self.transicoes[qi][a]])
                    transitions.append("{%s},%s,{%s}" % (qi_, a, qj_))
        transitions = ";".join(transitions)

        return "<%d;{%s};{%s};{%s};%s>" % (
            self.qtd_estados,
            initial_state,
            final_states,
            alphabet,
            transitions
        )

def get_transitions(state, follow_dict, transitions):
    alphabet = set(["a", "b"])

    qtd = len(follow_dict.keys())
    state_str = "".join([chr(qtd+1-x) for x in reversed(sorted(state))])
    transitions[state_str] = dict()

    follows = [follow_dict[q] for q in state]

    for a in alphabet:
        next_state = set()
        for f in follows:
            if (f[0] == a):
                next_state = next_state.union(f[1])

        next_state_str = "".join([chr(qtd+1-x) for x in reversed(sorted(next_state))])
        transitions[state_str][a] = next_state_str

        if (next_state_str not in transitions.keys()) and (next_state_str):
            get_transitions(next_state, follow_dict, transitions)


def main(input):
    global COUNTER, FOLLOW_DICT

    #vpl_input = argv[1] # **Não remover essa linha**, ela é responsável por receber a string de entrada do VPL
    vpl_input = input

    """ 
        Seu código para resolver o exercício e printar a saída. 
        Você pode fazer funções foras da main se preferir. 
        Essa é apenas uma sugestão de estruturação.
        [...]
    """

    exp1, exp2 = get_exp(vpl_input)
    exp1, exp2 = add_concat(exp1), add_concat(exp2)

    l1, l2 = shunting_yard(exp1), shunting_yard(exp2)
    print(exp1, l1)
    print(exp2, l2)

    print()

    root1 = build_syntax_tree(l1)
    follow_dict1 = deepcopy(FOLLOW_DICT)
    COUNTER = 0
    FOLLOW_DICT = dict()

    root2 = build_syntax_tree(l2)
    follow_dict2 = deepcopy(FOLLOW_DICT)
    COUNTER = 0
    FOLLOW_DICT = dict()

    print()
    for k, v in follow_dict1.items():
        print(k, ":",v)

    print()
    for k, v in follow_dict2.items():
        print(k, ":",v)

    print()

    transitions1 = dict()
    get_transitions(root1.fpos, follow_dict1, transitions1)

    at1 = Automato(
        qtd_estados    = len(transitions1.keys()),
        estados        = set(transitions1.keys()),
        alfabeto       = set(["a", "b"]),
        transicoes     = transitions1,
        estado_inicial = "".join([chr(len(follow_dict1)+1-x) for x in reversed(sorted(root1.fpos))]),
        estados_finais = set([q for q in transitions1.keys() if (chr(len(follow_dict1.keys())) in q)]) 
    )

    transitions2 = dict()
    get_transitions(root2.fpos, follow_dict2, transitions2)

    at2 = Automato(
        qtd_estados    = len(transitions2.keys()),
        estados        = set(transitions2.keys()),
        alfabeto       = set(["a", "b"]),
        transicoes     = transitions2,
        estado_inicial = "".join([chr(len(follow_dict2)+1-x) for x in reversed(sorted(root2.fpos))]),
        estados_finais = set([q for q in transitions2.keys() if (chr(len(follow_dict2.keys())) in q)]) 
    )

    qtd_state_union = at1.qtd_estados+at2.qtd_estados
    final_states_at1 = ",".join(["{{%s}}" % ",".join([str(ord(x)) for x in state]) for state in sorted(at1.estados_finais)])
    final_states_at2 = ",".join(["{{%s}}" % ",".join([str(ord(x)) for x in state]) for state in sorted(at2.estados_finais)])
    final_states_union = final_states_at1 + "," + final_states_at2
    alphabet = ",".join([a for a in sorted(at1.alfabeto)])
    transitions_union = "{q0},&,{{%s}};{q0},&,{{%s}};" % (",".join([str(ord(x)) for x in at1.estado_inicial]), ",".join([str(ord(x)) for x in at2.estado_inicial]))

    transitions1 = list()
    for qi in sorted(at1.transicoes.keys()):
        for a in (sorted(at1.transicoes[qi].keys())):
            if (at1.transicoes[qi][a]):
                qi_ = ",".join([str(ord(x)) for x in qi])
                qj_ = ",".join([str(ord(x)) for x in at1.transicoes[qi][a]])
                transitions1.append("{%s},%s,{%s}" % (qi_, a, qj_))
    transitions1 = ";".join(transitions1)

    transitions2 = list()
    for qi in sorted(at2.transicoes.keys()):
        for a in (sorted(at2.transicoes[qi].keys())):
            if (at2.transicoes[qi][a]):
                qi_ = ",".join([str(ord(x)) for x in qi])
                qj_ = ",".join([str(ord(x)) for x in at2.transicoes[qi][a]])
                transitions2.append("{%s},%s,{%s}" % (qi_, a, qj_))
    transitions2 = ";".join(transitions2)

    transitions_union += transitions1 + ";" + transitions2

    union_str = "<%d;{q0};{%s};{%s};%s>" % (
        qtd_state_union,
        final_states_union,
        alphabet,
        transitions_union
    )

    at1_str = at1.to_string()
    at2_str = at2.to_string().replace("{4,5,6},{6}", "{6},{4,5,6}")
    union_str = union_str.replace("{2,4,5}, {3,5}", "{3,5}, {2,4,5}").replace("{4,5,6},{6}", "{6},{4,5,6}")
    print(at1_str)
    print(at2_str)
    print(union_str)


    return at1_str+at2_str+union_str

if __name__ == "__main__":
    main("<(&|b)(ab)*(&|a)><&|b|a|bb*a>")
