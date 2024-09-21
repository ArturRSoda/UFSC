#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <stdlib.h>

#define PORT 1101

int main(int argc, char* argv[]) {
    int my_socket;
    struct sockaddr_in server_socket_addr;
    unsigned int server_socket_addr_len;
    int  ts;
    char buffer[100];
    int int_rand;

    my_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (my_socket < 0) {
        perror("Failed to create socket!");
        return -1;
    }

    server_socket_addr.sin_family = AF_INET;
    server_socket_addr.sin_addr.s_addr = INADDR_ANY;
    server_socket_addr.sin_port = htons(PORT);
    server_socket_addr_len = sizeof(server_socket_addr);

    srand(time(NULL));

    printf("sending numbers!\n");
    while (1) {
        int_rand = rand() % 100 + 1;
        sprintf(buffer, "%d", int_rand);
        ts = sendto(my_socket, buffer, 100, MSG_CONFIRM, (struct sockaddr *) &server_socket_addr, server_socket_addr_len);
        if (ts < 0) {
            perror("failed to send message!");
        }

    }

    close(my_socket);

    return 0;
}
