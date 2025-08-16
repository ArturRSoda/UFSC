#define _GNU_SOURCE
#include <unistd.h>
#include <sys/types.h>

#include <pthread.h>
#include <semaphore.h>

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

// -----Constantes-----
int cliente_n;
int garcom_n;
int capacidade;
int rodadas_n;
int tempo_conversa_ms;
int tempo_consumo_ms;
// --------------------

// -----Comunicacao entre threads------
sem_t garcom_atual;

pthread_mutex_t cliente_esta_pedindo;
sem_t cliente_pediu;
int id_cliente_pedindo;
sem_t garcom_atendeu;
int id_garcom_atendendo;
sem_t cliente_esperando;
sem_t* garcom_entregou;
sem_t cliente_recebeu;
// ------------------------------------

// ---------Comunicacao com Main----------
int rodada = 1;
sem_t bar_fechou;
bool* conversando_ou_pedindo;
sem_t tem_cliente_conversando_ou_pedindo;
// ---------------------------------------

void my_sleep(int time_ms) {
    int sec = time_ms / 1000;
    int milli = time_ms % 1000;

    struct timespec ts = {sec, ((long)milli)*1000000};
    nanosleep(&ts, NULL);
}

void conversaComAmigos(int cliente_i) {
    printf("Cliente %d: conversando com os amigos\n", cliente_i);
    fflush(stdout);
    int tempo_sleep = rand() % tempo_conversa_ms;
    my_sleep(tempo_sleep);
}

int fazPedido(int cliente_i) {
    printf("Cliente %d: fazendo pedido\n", cliente_i);
    fflush(stdout);

    pthread_mutex_lock(&cliente_esta_pedindo);      // Garante que um cliente esta sendo atendido por vez
    id_cliente_pedindo = cliente_i;                 // Indica qual cliente esta pedindo
    sem_post(&cliente_pediu);                       // Sinaliza que ja vez pedido
    sem_wait(&garcom_atendeu);                      // Espera garcom atender

    conversando_ou_pedindo[cliente_i] = false;      // Indica que foi atendido, ou seja, nao esta conversando ou pedindo
    sem_wait(&tem_cliente_conversando_ou_pedindo);  // Sinaliza a main que foi atendido

    int garcom_i = id_garcom_atendendo;             // Le o garcom que o atendeu
    pthread_mutex_unlock(&cliente_esta_pedindo);    // Libera o proximo cliente, para o atendidmento

    return garcom_i;
}

void esperaPedido(int cliente_i, int garcom_i) {
    printf("Cliente %d: esperando pedido do garcom %d\n", cliente_i, garcom_i);
    fflush(stdout);

    sem_post(&cliente_esperando);          // Notificar garcom que esta esperando pedido
    sem_wait(&garcom_entregou[cliente_i]); // Espera garcom entregar o pedido
}

void recebePedido(int cliente_i, int garcom_i) {
    printf("Cliente %d: recebeu o pedido do garcom %d\n", cliente_i, garcom_i);
    fflush(stdout);

    sem_post(&cliente_recebeu); // Notifica ao garcom que recebeu o pedido
}

void consomePedido(int cliente_i) {
    printf("Cliente %d: consumindo sua bebida\n", cliente_i);
    fflush(stdout);
    my_sleep(rand() % tempo_consumo_ms);
}

// Execucao Cliente
void cliente_func(void* arg) {
	// Identificador Cliente
    int cliente_i = *(int*)arg;

    while (true){
        conversando_ou_pedindo[cliente_i] = true;      // Indica que esta conversando ou pedindo, ou seja, nao foi atendido
        sem_post(&tem_cliente_conversando_ou_pedindo); // Sinaliza a main que existe um cliente conversando ou pedindo

		// "Vai embora" caso bar fechou
        if (rodada > rodadas_n) pthread_exit(0);

		// Ordem de execucao
        conversaComAmigos(cliente_i);        
        int garcom_i = fazPedido(cliente_i); 
        esperaPedido(cliente_i, garcom_i);  
        recebePedido(cliente_i, garcom_i); 
        consomePedido(cliente_i);         
    }
}

void recebeMaximoPedidos(int garcom_i, int* clientes) {
    printf("Garcom %d: recebendo pedidos\n", garcom_i);
    fflush(stdout);
    for (int i = 0; i < capacidade; i++) {
        sem_wait(&cliente_pediu);         // Espera cliente fazer pedido
        clientes[i] = id_cliente_pedindo; // Salva id do cliente que fez pedido
        id_garcom_atendendo = garcom_i;   // Indica qual garcom esta atendendo
        sem_post(&garcom_atendeu);        // Atende cliente
        sem_wait(&cliente_esperando);     // Espera o cliente notificar que esta esperando pedido (Para garantir a ordem)
    }
}

// Registra pedidos na Copa
void registraPedidos(int garcom_i, int* clientes) {
    for (int i = 0; i < capacidade; i++) {
        printf("Garcom %d: cliente %d pediu bebida\n", garcom_i, clientes[i]);
        fflush(stdout);
    }
}

// Entrega os pedidos na ordem de recebimento
void entregaPedidos(int garcom_i, int* clientes) {
    for (int i = 0; i < capacidade; i++) {
        printf("Garcom %d: entregou bebida para cliente %d\n", garcom_i, clientes[i]);
        fflush(stdout);

        sem_post(&garcom_entregou[clientes[i]]); // Sinaliza que entregou o pedido
        sem_wait(&cliente_recebeu);              // Espera o clientre receber o pedido (Garantir ordem)
    }
}

// Execucao do Garcom
void garcom_func(void* arg) {
	// Identificador garcom
    int garcom_i = *(int*)arg;

	// Clientes que estao sendo atendidos
    int clientes[capacidade];

    while(true) {
		// Espera sua vez de atender
        sem_wait(&garcom_atual);

		// Imprime Rodada
        printf("\nRodada: %d\n", rodada);
        fflush(stdout);

		// Recebe seu maximo de pedidos e incrementa rodada
        recebeMaximoPedidos(garcom_i, clientes);
        rodada++;

		// Libera o proximo garcom para poder atender
        if (rodada <= rodadas_n) {
            sem_post(&garcom_atual);
        }

		// Registra e entrega os pedidos
        registraPedidos(garcom_i, clientes);
        entregaPedidos(garcom_i, clientes);

		// Libera o main para terminar execucao,
		// Caso alcancar numero maximo de rodadas
        if (rodada > rodadas_n) {
            sem_post(&bar_fechou);
        }
    }
}

// Inicializacao semaforos e mutex
void init() {

    sem_init(&garcom_atual, 0, 1);

    pthread_mutex_init(&cliente_esta_pedindo, 0);

    sem_init(&cliente_pediu, 0, 0);
    sem_init(&garcom_atendeu, 0, 0);
    sem_init(&cliente_esperando, 0, 0);
    sem_init(&cliente_recebeu, 0, 0);

    garcom_entregou = (sem_t*)malloc(sizeof(sem_t)*cliente_n);
    for (int i = 0; i < cliente_n; i++) {
        sem_init(&garcom_entregou[i], 0, 0);
    }

    sem_init(&bar_fechou, 0, 0);
    conversando_ou_pedindo = (bool*)calloc(cliente_n, sizeof(bool));
    sem_init(&tem_cliente_conversando_ou_pedindo, 0, 0);
}

// Destruindo semaforos e mutex
void destroy() {
    sem_destroy(&garcom_atual);

    pthread_mutex_destroy(&cliente_esta_pedindo);

    sem_destroy(&cliente_pediu);
    sem_destroy(&garcom_atendeu);
    sem_destroy(&cliente_esperando);
    sem_destroy(&cliente_recebeu);

    for (int i = 0; i < cliente_n; i++) {
        sem_destroy(&garcom_entregou[i]);
    }
    free(garcom_entregou);


    sem_destroy(&bar_fechou);
    free(conversando_ou_pedindo);
    sem_destroy(&tem_cliente_conversando_ou_pedindo);
}

int main(int argc, char **argv) {
	// Verifica argumentos
    if (argc != 7) {
        fprintf(stderr, "O numero de argumentos deve ser 7\n");
        return EXIT_FAILURE;
    }

	// Define Constantes globais
    cliente_n = atoi(argv[1]);
    garcom_n = atoi(argv[2]);
    capacidade = atoi(argv[3]);
    rodadas_n = atoi(argv[4]);
    tempo_conversa_ms = atoi(argv[5]);
    tempo_consumo_ms = atoi(argv[6]);

	// Ajusta capacidade do garcom
    if (capacidade > cliente_n) capacidade = cliente_n;

	// Inicia semaforos e mutex
    init();

	// Inicia threads garcons
    pthread_t garcons[garcom_n];
    int id_garcons[garcom_n];
    for (int i = 0; i < garcom_n; i++) {
        id_garcons[i] = i;
        pthread_create(&garcons[i], 0, (void*)garcom_func, &id_garcons[i]);
    }

	// Inicia threads clientes
    pthread_t clientes[cliente_n];
    int id_clientes[cliente_n];
    for (int i = 0; i < cliente_n; i++) {
        id_clientes[i] = i;
        pthread_create(&clientes[i], 0, (void*)cliente_func, &id_clientes[i]);
    }

	// Espera o bar fechar para terminar execucao
    sem_wait(&bar_fechou);

	// Join nos garcons
    for (int i = 0; i < garcom_n; i++) {
        pthread_cancel(garcons[i]);
		pthread_join(garcons[i], NULL);
    }

	// Join nos clientes, apenas aqueles que estao conversando ou pedindo, ou seja, nao foram atendidos
    int clientes_restantes = cliente_n;
    while (clientes_restantes > 0) {
        sem_wait(&tem_cliente_conversando_ou_pedindo); // Espera ter algum cliente que nao foi atendido
        for (int i = 0; i < cliente_n; i++) {
            if (conversando_ou_pedindo[i]) {
                conversando_ou_pedindo[i] = false;
                pthread_cancel(clientes[i]);
                pthread_join(clientes[i], NULL);

                clientes_restantes--;
                break;
            }
        }
    }

	// Destroi semaforos e mutex
	destroy();

	printf("\nBar fechado!\n");

    return EXIT_SUCCESS;
}

