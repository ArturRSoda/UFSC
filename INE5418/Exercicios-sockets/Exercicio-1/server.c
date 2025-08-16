#include <stdio.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    int server_socket, client_socket;
    struct sockaddr_un server_addr, client_socket_addr;
    unsigned int server_addr_len, client_socket_addr_len;
    int b, l, dr, ds;
    char buffer[100];

    server_socket = socket(AF_UNIX, SOCK_STREAM, 0);
    if (server_socket < 0) {
        perror("failetd to create server socket!");
        return -1;
    }
    server_addr.sun_family = AF_UNIX;
    strcpy(server_addr.sun_path, "socket_buffer");
    unlink(server_addr.sun_path);
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
