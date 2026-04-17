#include <ifaddrs.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(void) {
    struct ifaddrs *ifa, *p;
    if (getifaddrs(&ifa)) return 1;
    for (p = ifa; p; p = p->ifa_next) {
        if (!p->ifa_addr || p->ifa_addr->sa_family != AF_INET) continue;
        uint32_t addr = ntohl(((struct sockaddr_in *)p->ifa_addr)->sin_addr.s_addr);
        if ((addr & 0xFFC00000) == 0x64400000) { // 100.64.0.0/10
            freeifaddrs(ifa);
            return 0;
        }
    }
    freeifaddrs(ifa);
    return 1;
}
