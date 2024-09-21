#include <asm-generic/socket.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>

#define PORT 1101
#define TIME_OUT_MS 100000
#define BUFFER_SIZE 100

int main(int argc, char *argv[]) {
    int server_socket;
    struct sockaddr_in server_addr, client_socket_addr;
    unsigned int server_addr_len, client_socket_addr_len;
    int b, l, dr, ds, ts;
    char buffer[BUFFER_SIZE];
    struct timeval tv;
    float sum, acc;
    time_t start, end;
    double dif;

    server_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (server_socket < 0) {
        perror("failetd to create server socket!");
        return -1;
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(PORT);
    server_addr_len = sizeof(server_addr);

    tv.tv_sec = 0;
    tv.tv_usec = TIME_OUT_MS;
    ts = setsockopt(server_socket, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
    if (ts < 0) {
        perror("set socket error!");
        return -1;
    }

    b = bind(server_socket, (struct sockaddr *) &server_addr, server_addr_len);
    if (b < 0) {
        perror("failed to bind!");
        return -1;
    }

    printf("server ready!\n");

    client_socket_addr_len = sizeof(client_socket_addr);
    acc = 0; sum = 0;
    time(&start);
    while (1) {
        dr = recvfrom(server_socket, buffer, BUFFER_SIZE, MSG_WAITALL, (struct sockaddr *) &client_socket_addr, &client_socket_addr_len);
        if (dr >= 0) {
            sum = sum + atoi(buffer);
            acc++;
        }

        time(&end);
        dif = difftime(end, start);
        if (dif >= 1) {
            printf("Colected Value %.1f\n", sum);
            printf("numbers qtd: %.1f\n", acc);
            printf("Average: %.2f\n", sum/acc);
            printf("\n");
            time(&start);
            sum = 0; acc = 0;
        }

    }

    close(server_socket);

    return 0;
} 
