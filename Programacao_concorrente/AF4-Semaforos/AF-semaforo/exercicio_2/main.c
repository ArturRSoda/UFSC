#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>

/* ---------- Definições Globais. ---------- */
#define TEMPO_BASE 1000000

typedef enum { 
	CONTINENTE, 
	ILHA 
} cabeceira_t;

typedef struct {
	int id;
	cabeceira_t cabeceira;
	pthread_t thread;
} veiculo_t;
/* ---------------------------------------- */

/* ---------- Variáveis Globais. ---------- */
char cabeceiras[2][11] = { { "CONTINENTE" }, { "ILHA" } };
int total_veiculos;
int veiculos_turno;

char* sentido;
int contador_veiculo;
pthread_mutex_t mutex_contador;
sem_t sem_ilha;
sem_t sem_continente;
sem_t sinal_ilha;
sem_t sinal_continente;

// ToDo: Adicione aque quaisquer outras variávels globais necessárias.
/* ---------------------------------------- */

/* Inicializa a ponte. */
void ponte_inicializar() {
	
	// ToDo: IMPLEMENTAR!
	
	sem_init(&sem_ilha, 0, veiculos_turno);
	sem_init(&sem_continente, 0, veiculos_turno);
	sem_init(&sinal_continente, 0, 1);
	sem_init(&sinal_ilha, 0, 1);
	pthread_mutex_init(&mutex_contador, NULL) ;


	sentido = "ILHA";
	contador_veiculo = 0;

	/* Imprime direção inicial da travessia. NÃO REMOVER! */
	printf("\n[PONTE] *** Novo sentido da travessia: CONTINENTE -> ILHA. ***\n\n");
	fflush(stdout);
}

/* Função executada pelo veículo para ENTRAR em uma cabeceira da ponte. */
void ponte_entrar(veiculo_t *v) {
	char* cabeceira_veiculo = cabeceiras[v->cabeceira];
	// 0->continente
	// 1->ilha

	if (strcmp(cabeceira_veiculo, "CONTINENTE")) {
		sem_wait(&sem_continente);
	}
	else if (strcmp(cabeceira_veiculo, "ILHA")) {
		sem_wait(&sem_ilha);
	}

}

/* Função executada pelo veículo para SAIR de uma cabeceira da ponte. */
void ponte_sair(veiculo_t *v) {
	char* cabeceira_veiculo = cabeceiras[v->cabeceira];
	// 0->continente
	// 1->ilha


	if (strcmp(cabeceira_veiculo, "CONTINENTE")) {
		sem_post(&sem_continente);
	}
	else if (strcmp(cabeceira_veiculo, "ILHA")) {
		sem_post(&sem_ilha);
	}

	pthread_mutex_lock(&mutex_contador);
	contador_veiculo++;
	pthread_mutex_unlock(&mutex_contador);

	if (contador_veiculo == veiculos_turno) {
		sentido = cabeceiras[!v->cabeceira];
		contador_veiculo = 0;

		/* Você deverá imprimir a nova direção da travessia quando for necessário! */	
		printf("\n[PONTE] *** Novo sentido da travessia: %s -> %s. ***\n\n", cabeceiras[v->cabeceira], cabeceiras[!v->cabeceira]);
		fflush(stdout);
	}

}

/* FINALIZA a ponte. */
void ponte_finalizar() {

	sem_destroy(&sem_ilha);
	sem_destroy(&sem_continente);
	pthread_mutex_destroy(&mutex_contador);
	
	/* Imprime fim da execução! */
	printf("[PONTE] FIM!\n\n");
	fflush(stdout);
}

/* Implementa o comportamento de um veículo. */
void * veiculo_executa(void *arg) {
	veiculo_t *v = (veiculo_t *) arg;
	
	printf("[Veiculo %3d] Aguardando para entrar na ponte pelo(a) %s.\n", v->id, cabeceiras[v->cabeceira]);
	fflush(stdout);

	/* Entra na ponte. */
	ponte_entrar(v);
	printf("[Veiculo %3d] ENTROU na ponte pelo(a) %s.\n", v->id, cabeceiras[v->cabeceira]);
	fflush(stdout);

	/* Faz a travessia. */
	usleep(TEMPO_BASE + rand() % 1000);
	
	/* Seta cabeceira oposta para sair. */
	v->cabeceira = !v->cabeceira;

	/* Sai da ponte na cabeceira oposta. */
	printf("[Veiculo %3d] SAIU da ponte pelo(a) %s.\n", v->id, cabeceiras[v->cabeceira]);
	fflush(stdout);
	ponte_sair(v);

	pthread_exit(NULL);
}

/* Função principal: NÃO PODE ALTERAR! */
int main(int argc, char **argv) {
 
	if (argc < 3) {
		printf("Indique a quantidade total de veiculos e o numero de veiculos que podem atravessar a ponte por turno:\n\n %s [QTD_TOTAL_VEICULOS] [VEICULOS_POR_TURNO]\n\n", argv[0]);
		return 1;
	}

	total_veiculos = atoi(argv[1]);
	veiculos_turno = atoi(argv[2]);

	if (total_veiculos % (veiculos_turno * 2)) {
		printf("ERRO: O valor [QTD_TOTAL_VEICULOS] deve ser divisivel por ([VEICULOS_POR_TURNO] * 2)!\n\n %s [QTD_TOTAL_VEICULOS] [VEICULOS_POR_TURNO]\n\n", argv[0]);
		return 1;
	}

	srand(time(NULL));

	/* Aloca os veículos. */
	veiculo_t veiculos[total_veiculos];

	ponte_inicializar();

	/* Cria os veículos. */
	for (int i = 0; i < total_veiculos; i++) {
		/* Define o id do veículo. */
		veiculos[i].id = i;
		
		/* Escolhe aleatoreamente se o veículo entra pela ILHA ou CONTINENTE. */
		veiculos[i].cabeceira = i % 2; 
		
		/* Cria a thread veículo. */
		pthread_create(&veiculos[i].thread, NULL, veiculo_executa, (void *) &veiculos[i]);		
	}

	/* Aguarda o término da execução de todos os veículos antes de finalizar o programa. */
	for (int i = 0; i < total_veiculos; i++) {
		pthread_join(veiculos[i].thread, NULL);
	}

	ponte_finalizar();

	return 0;
}
