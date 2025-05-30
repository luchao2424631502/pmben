
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <stddef.h>
#include <unistd.h>
#include <sys/mman.h>

#include <libpmem2.h>

int main() {
    size_t map_size = 128*(1<<20);

    int32_t dax_fd = open("/dev/dax1.0", O_RDWR);
    if (dax_fd == -1)
    {
        printf("!!! DAX DEVICE Could not open file: ");
    }

    void *addr = mmap(0, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);
    close(dax_fd);
    if (addr == MAP_FAILED || addr == NULL)
    {
        printf("!!! DAX DEVICE Could not map file Error: ");
    }

    return 0;
}