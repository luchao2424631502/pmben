
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <stddef.h>
#include <unistd.h>

#include <libpmem2.h>

int main() {
    size_t map_size = 4096;

    struct pmem2_config *cfg;
    if (pmem2_config_new(&cfg)) {
        fprintf(stderr, "Error: pmem2_config_new failed\n");
        return 1;
    }

    // 设置对齐方式（通常为 4KB 或硬件页大小）
    if (pmem2_config_set_length(cfg, 4096)) {
        fprintf(stderr, "Error: pmem2_config_set_alignment failed\n");
        goto err_config;
    }

    struct pmem2_source *src;
    int fd = open("/dev/pmem0", O_RDWR);
    pmem2_source_from_fd(&src, fd);
    
    // libpmem2 不会使用 MAP_SYNC
    struct pmem2_map *map;
    pmem2_map_new(&map, cfg, src);
    
    // 必须显式调用 pmem_persist() 来确保持久化
    void *addr;
    size_t length;

    addr = pmem2_map_get_address(map);

    memcpy((char *)addr, "luchao", strlen("luchao"));

    printf("%lu\n", pmem2_map_get_size(map));

    pmem2_deep_flush(map, addr, strlen("luchao"));
    
err_config:
    pmem2_config_delete(&cfg);
    if (src)
    {
        pmem2_source_delete(&src);
    }
    if (fd >= 0)
    {
        close(fd);
    }
    return 0;
}