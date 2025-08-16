#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char* argv[]) {
    int my_socket;
    struct sockaddr_un server_socket_addr;
    unsigned int server_socket_addr_len;
    int tc, ts;
    char buffer[100];

    if (argc < 2) {
        printf("Plese pass an argument!\n");
        return -1;
    }

    my_socket = socket(AF_UNIX, SOCK_STREAM, 0);
    if (my_socket < 0) {
        perror("Failed to create socket!");
        return -1;
    }

    server_socket_addr.sun_family = AF_UNIX;
    strcpy(server_socket_addr.sun_path, "socket_buffer");
    server_socket_addr_len = sizeof(server_socket_addr);

    strcpy(buffer, argv[1]);

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
