#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <sys/types.h>

#define PORT 1101
#define N_THREADS 4

sem_t semaphore;

void thread_func(void* arg) {
    char buffer[100]; 
    int client_socket = *(int*)arg;

    recv(client_socket, buffer, 100, 0);
    fflush(stdout);
    printf("thread received %s\n", buffer);

    send(client_socket, buffer, 100, 0);
    fflush(stdout);
    printf("thread returned %s\n\n\n", buffer);

    sleep(5);

    close(client_socket);
    sem_post(&semaphore);

}

int main(int argc, char *argv[]) {
    int server_socket, client_socket;
    struct sockaddr_in server_addr, client_socket_addr;
    unsigned int server_addr_len, client_socket_addr_len;
    int b, l, dr, ds;
    char* tokens;
    float n1, n2, r;
    char op;
    pthread_t thread_arr[15];
    int thread_id;

    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket < 0) {
        perror("failetd to create server socket!");
        return -1;
    }
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(PORT);
    server_addr_len = sizeof(server_addr);

    b = bind(server_socket, (struct sockaddr *) &server_addr, server_addr_len);
    if (b < 0) {
        perror("failed to bind!");
        return -1;
    }

    l = listen(server_socket, 5);
    if (l < 0) {
        perror("listen error!");
        return -1;
    }

    sem_init(&semaphore, 0, N_THREADS);
    thread_id = 0;
    while (1) {
        fflush(stdout);
        printf("server waiting semaphore!\n");

        sem_wait(&semaphore);

        fflush(stdout);
        printf("server waiting connect!\n");
        client_socket_addr_len = sizeof(client_socket_addr);
        client_socket = accept(server_socket, (struct sockaddr *) &client_socket_addr, &client_socket_addr_len);
        if (client_socket < 0) {
            perror("failet to connetct!");
            return -1;
        }

        if (pthread_create(&thread_arr[thread_id], 0, (void*)thread_func, &client_socket) < 0) {
            fflush(stdout);
            printf("failed to create pthread\n");
        }

        thread_id++;
        if (thread_id > 10) { thread_id = 0; }
    }

    for (int i = 0; i < 15; i++) {
        pthread_join(thread_arr[i], NULL);
    }
    sem_destroy(&semaphore);

    close(server_socket);

    return 0;
} 
