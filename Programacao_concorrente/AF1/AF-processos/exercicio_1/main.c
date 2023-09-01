#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>



//       (pai)      
//         |        
//    +----+----+
//    |         |   
// filho_1   filho_2


// ~~~ printfs  ~~~
// pai (ao criar filho): "Processo pai criou %d\n"
//    pai (ao terminar): "Processo pai finalizado!\n"
//  filhos (ao iniciar): "Processo filho %d criado\n"

// Obs:
// - pai deve esperar pelos filhos antes de terminar!

pid_t criarFilho();

int main(int argc, char** argv) {
	criarFilho();
	criarFilho();

	while (wait(NULL) >= 0) {}

    printf("Processo pai finalizado!\n");   
	fflush(stdout);
    return 0;
}

pid_t criarFilho() {
	pid_t pid = fork();
	
	if (pid < 0) {
		printf("Falha no fork\n");
		fflush(stdout);
		exit(-1);
	}

	if (pid == 0) {
		printf("Processo filho %d criado\n", getpid());
		fflush(stdout);
		exit(0);
	}

	printf("Processo pai criou %d\n", pid);
	fflush(stdout);

	return pid;
}
