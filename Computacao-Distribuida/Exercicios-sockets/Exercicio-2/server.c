#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdlib.h>

#define PORT 1101

int main(int argc, char *argv[]) {
    int server_socket, client_socket;
    struct sockaddr_in server_addr, client_socket_addr;
    unsigned int server_addr_len, client_socket_addr_len;
    int b, l, dr, ds;
    char buffer[100];
    char* tokens;
    float n1, n2, r;
    char op;

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


    while (1) {
        printf("server waiting!\n");
        client_socket_addr_len = sizeof(client_socket_addr);
        client_socket = accept(server_socket, (struct sockaddr *) &client_socket_addr, &client_socket_addr_len);
        if (client_socket < 0) {
            perror("failet to connetct!");
            return -1;
        }

        dr = recv(client_socket, buffer, 100, 0);
        if (dr < 0) {
            perror("failed to receive!");
            return -1;
        }

        printf("Data received: %s\n", buffer);

        tokens = strtok(buffer, " ");
        n1 = atof(tokens);
        tokens = strtok(NULL, " ");
        op = *tokens;
        tokens = strtok(NULL, " ");
        n2 = atof(tokens);

        switch (op) {
            case '+':
                r = n1 + n2;
                break;
            case '-':
                r = n1 - n2;
                break;
            case '*':
                r = n1 * n2;
                break;
            case '/':
                r = n1 / n2;
                break;
            default:
                printf("gay");
        }

        printf("result = %.2f\n", r);
        
        sprintf(buffer, "%.2f", r);

        ds = send(client_socket, buffer, 100, 0);
        if (ds < 0) {
            perror("failed to send!");
            return -1;
        }


        close(client_socket);
    }
    close(server_socket);

    return 0;
} 
