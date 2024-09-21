#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <unistd.h>

#define PORT 1101

int main(int argc, char* argv[]) {
    int my_socket;
    struct sockaddr_in server_socket_addr;
    unsigned int server_socket_addr_len;
    int tc, ts;
    char buffer[100];

    if (argc != 4) {
        printf("arguments should be: n1 op n2\n");
        return -1;
    }

    strcpy(buffer, argv[1]);
    strcat(buffer, " ");
    strcat(buffer, argv[2]);
    strcat(buffer, " ");
    strcat(buffer, argv[3]);

    my_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (my_socket < 0) {
        perror("Failed to create socket!");
        return -1;
    }

    server_socket_addr.sin_family = AF_INET;
    server_socket_addr.sin_addr.s_addr = INADDR_ANY;
    server_socket_addr.sin_port = htons(PORT);
    server_socket_addr_len = sizeof(server_socket_addr);


    tc = connect(my_socket, (struct sockaddr *) &server_socket_addr, server_socket_addr_len);
    if (tc < 0) {
        perror("Failed to connect");
        return -1;
    }

    printf("client connected!\n");
    
    ts = send(my_socket, buffer, 100, 0);
    if (ts < 0) {
        perror("failed to send message!");
        return -1;
    }

    ts = recv(my_socket, buffer, 100, 0); 
    if (ts < 0) {
        perror("failed to receive message!");
        return -1;
    }

    printf("received from server = %s\n", buffer);

    close(my_socket);

    return 0;
}
