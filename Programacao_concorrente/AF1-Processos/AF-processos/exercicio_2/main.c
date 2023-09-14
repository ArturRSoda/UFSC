#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>

//                          (principal)
//                               |
//              +----------------+--------------+
//              |                               |
//           filho_1                         filho_2
//              |                               |
//    +---------+-----------+          +--------+--------+
//    |         |           |          |        |        |
// neto_1_1  neto_1_2  neto_1_3     neto_2_1 neto_2_2 neto_2_3

// ~~~ printfs  ~~~
//      principal (ao finalizar): "Processo principal %d finalizado\n"
// filhos e netos (ao finalizar): "Processo %d finalizado\n"
//    filhos e netos (ao inciar): "Processo %d, filho de %d\n"

// Obs:
// - netos devem esperar 5 segundos antes de imprmir a mensagem de finalizado (e terminar)
// - pais devem esperar pelos seu descendentes diretos antes de terminar

pid_t criarFilho(void (*f)());
void procFilho();
void procNeto();

int main(int argc, char** argv) {
	criarFilho(procFilho);
	criarFilho(procFilho);

	while (wait(NULL) >= 0) {}

    printf("Processo principal %d finalizado\n", getpid());    
	fflush(stdout);

    return 0;
}

pid_t criarFilho(void (*f)()) {
	pid_t pid = fork();

	if (pid < 0) {
		printf("Falha no fork\n");
		fflush(stdout);
		exit(-1);
	}

	if (pid == 0) {
		printf("Processo %d, filho de %d\n", getpid(), getppid());
		fflush(stdout);
		f();
		printf("Processo %d finalizado\n", getpid());
		fflush(stdout);
		exit(0);
	}

	return pid;
}

void procFilho() {
	criarFilho(procNeto);
	criarFilho(procNeto);
	criarFilho(procNeto);

	while (wait(NULL) >= 0) {}
}

void procNeto() {
	sleep(5);
}

