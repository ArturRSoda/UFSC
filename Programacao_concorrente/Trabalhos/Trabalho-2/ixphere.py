from sys import argv
from time import sleep, time_ns
from random import seed, randint
from enum import Enum
from queue import Queue
from threading import Thread, Semaphore, Lock, Condition

# Indica faixa_etaria
class Experiencia(Enum):
    A = 0
    B = 1
    C = 2

# -----Constantes-----
n_pessoas:     int
n_vagas:       int
permanencia:   int
max_intervalo: int
semente:       int
unid_tempo:    int
# --------------------

thread_pessoas: list[Thread]

# -----Sincronizacao das pessoas-----
fila: list[Semaphore]
tem_vagas_disponiveis: Semaphore
entrando_ou_saindo: Lock
pode_entrar: Condition

id_do_primeiro: int

experiencia_atual: Experiencia|None
n_vagas_disponiveis: int
# -----------------------------------

# ----------Contangem de tempo----------
espera_total: dict[Experiencia, float]

inicio_da_experiencia: int
total_de_experiencia: int
# --------------------------------------

def func_pessoa(id_pessoa: int, faixa_etaria: Experiencia) -> None:
    global id_do_primeiro
    global experiencia_atual
    global n_vagas_disponiveis
    global inicio_da_experiencia
    global total_de_experiencia

    tempo_inicial = time_ns()

    print('[Pessoa {} / {}] Aguardando na fila.'.format(id_pessoa+1, faixa_etaria.name))

    # Espera ser o primeiro da fila
    fila[id_pessoa].acquire()

    # Espera ter vagas disponiveis
    tem_vagas_disponiveis.acquire()

    with entrando_ou_saindo:
        # Espera caso nao for sua faixa etaria
        while not (experiencia_atual is None or faixa_etaria == experiencia_atual):
            pode_entrar.wait()

        # Entra na ixfera
        n_vagas_disponiveis -= 1

        # Muda a faixa etaria, caso nao tenha ninguem dentro da ixphera
        if experiencia_atual is None:
            inicio_da_experiencia = time_ns()
            experiencia_atual = faixa_etaria
            print('[Ixfera] Iniciando a experiencia {}.'.format(experiencia_atual.name))

        print('[Pessoa {} / {}] Entrou na Ixfera (quantidade = {}).'
            .format(id_pessoa+1, faixa_etaria.name, n_vagas - n_vagas_disponiveis)
        )

        # Se nao for o ultimo da fila, libera a pessoa de traz da fila
        if id_do_primeiro < len(fila)-1:
            id_do_primeiro += 1
            fila[id_do_primeiro].release()

    espera_total[faixa_etaria] += (time_ns() - tempo_inicial) / 1000000

    # Espera permanencia tempo
    tempo_em_seg = permanencia * unid_tempo / 1000
    sleep(tempo_em_seg)

    with entrando_ou_saindo:
        # Sai da ixphera
        n_vagas_disponiveis += 1
        print('[Pessoa {} / {}] Saiu da Ixfera (quantidade = {}).'
            .format(id_pessoa+1, faixa_etaria.name, n_vagas - n_vagas_disponiveis)
        )

        # Se foi o ultimo a sair da sua experiencia, Pausa a experiencia 
        # E notifica que a experiencia foi pausada
        if n_vagas_disponiveis == n_vagas:
            total_de_experiencia += time_ns() - inicio_da_experiencia
            print('[Ixfera] Pausando a experiencia {}.'
                .format(experiencia_atual.name)
            )
            experiencia_atual = None
            pode_entrar.notify()

        # Sinaliza que tem vaga disponevel
        tem_vagas_disponiveis.release()

def criar_pessoas(qtd_por_faixa_etaria: dict[Experiencia, int]) -> None:
    #Cria as threads pessoas
    for id_pessoa in range(n_pessoas):
        faixa_etaria: Experiencia
        while True:
            exper_i = Experiencia(randint(0, 2)) # Sorteia faixa etaria

            # Verifica se ja alcacou a qtd de pessoas na faixa etaria escolhida
            if qtd_por_faixa_etaria[exper_i] > 0:
                qtd_por_faixa_etaria[exper_i] -= 1
                faixa_etaria = Experiencia(exper_i)
                break

        #Cria thread Pessoas
        pessoa = Thread(target=func_pessoa, args=(id_pessoa, faixa_etaria))
        thread_pessoas.append(pessoa)
        pessoa.start()

        # Se nao for a ultima pessoas, espera o max_intervalo
        if id_pessoa < n_pessoas - 1:
            tempo_em_seg = randint(0, max_intervalo) * unid_tempo / 1000
            sleep(tempo_em_seg)

# inicializa semaforos, locks e variaveis condicionais
def init() -> None:
    global thread_pessoas
    global fila
    global tem_vagas_disponiveis
    global entrando_ou_saindo
    global pode_entrar
    global id_do_primeiro
    global experiencia_atual
    global n_vagas_disponiveis
    global espera_total
    global inicio_da_experiencia
    global total_de_experiencia

    # Define seed
    seed(semente)

    # Lista que guardara as threads pessoas
    thread_pessoas = []

    # Id do primeiro da fila
    id_do_primeiro = 0

    # Lista de semaforos de cada pessoa da fila
    fila = []
    for i in range(n_pessoas):
        fila.append(Semaphore(0))
    fila[0].release() # Ja libera o primerio

    # Semaforo que indica se tem vaga disponivel no momento
    tem_vagas_disponiveis = Semaphore(n_vagas)

    # Numero de vagas disponiveis no momento
    n_vagas_disponiveis = n_vagas

    # Indica experiencia do moemnto
    experiencia_atual = None

    # Lock que indica se ha pessoa entrando ou saindo da atracao
    entrando_ou_saindo = Lock()

    # Variavel condicional ligado a entrando_ou_saindo
    # Permite que pessoa entre caso passe por todas as verificacoes
    pode_entrar = Condition(entrando_ou_saindo)

    # Guarda a espera total para ingressar na Ixfera por faixa etaria
    espera_total = {}
    for i in range(len(Experiencia)):
        espera_total[Experiencia(i)] = 0

    # Tempo do inicio de inicio da experiencia
    inicio_da_experiencia = 0
    # Tempo total que a atracao ficou funcionando
    total_de_experiencia = 0

def main() -> None:
    global n_pessoas
    global n_vagas
    global permanencia
    global max_intervalo
    global semente
    global unid_tempo
    global espera_total
    global total_de_experiencia

    # Verifica argumentos
    if len(argv) != 7:
        print('Numero de argumentos invalido')
        return

    # Define constantes globais
    n_pessoas = int(argv[1])
    n_vagas = int(argv[2])
    permanencia = int(argv[3])
    max_intervalo = int(argv[4])
    semente = int(argv[5])
    unid_tempo = int(argv[6])

    # Inicializa semaforos, locks, variavel condicional, variaveis para tempo
    init()

    # Dicionario que indica qtd de pessoas em cada faixa etaria
    qtd_por_faixa_etaria: dict[Experiencia, int] = {}

    # Divide a qtd de pessoas nas faixas etarias
    tam = n_pessoas // len(Experiencia)
    for i in range(len(Experiencia)):
        if i < n_pessoas % len(Experiencia):
            qtd_por_faixa_etaria[Experiencia(i)] = tam + 1
        else:
            qtd_por_faixa_etaria[Experiencia(i)] = tam

    inicio_da_simulacao = time_ns()
    print('[Ixfera] Simulacao iniciada.')

    # Thread que inicializa as pessoas
    cria_pessoas = Thread(target=criar_pessoas, args=(qtd_por_faixa_etaria.copy(),))
    cria_pessoas.start()
    cria_pessoas.join()

    # join nas pessoas
    for pessoa in thread_pessoas:
        pessoa.join()

    print('[Ixfera] Simulacao finalizada.')
    total_da_simulacao = time_ns() - inicio_da_simulacao

    print()
    print('Tempo medio de espera:')
    for exp_i in Experiencia:
        media = espera_total[exp_i] / qtd_por_faixa_etaria[exp_i]
        print('Faixa {}: {:.2f}'.format(exp_i.name, media))

    print()
    taxa_de_ocupacao = total_de_experiencia / total_da_simulacao
    print('Taxa de ocupacao: {:.2f}'.format(taxa_de_ocupacao))

main()

