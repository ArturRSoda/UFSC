#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
int main() {
  int sockfd;
  int len;
  struct sockaddr_in address;
  int result;
  char ch = 'A';

  sockfd = socket(AF_INET, SOCK_STREAM, 0);

  address.sin_family = AF_INET;
  // address.sin_addr.s_addr = inet_addr("127.0.0.1");
  // address.sin_addr.s_addr = inet_addr("10.0.2.15");
  // address.sin_addr.s_addr = inet_addr("150.162.65.181");
  address.sin_addr.s_addr = htonl(INADDR_ANY);
  address.sin_port = htons(9734);

  len = sizeof(address);
  result = connect(sockfd, (struct sockaddr *)&address, len);
  if (result == -1) {
    perror("oops: client1");
    exit(1);
  }
  write(sockfd, &ch, 1);
  // sleep(30);
  read(sockfd, &ch, 1);
  printf("char from server = %c\n", ch);
  close(sockfd);
  exit(0);
}
