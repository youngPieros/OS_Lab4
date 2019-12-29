#include "types.h"
#include "stat.h"
#include "user.h"

#define PROCESS_NUMBER 5

int main()
{
    int pid, id, i, j, busyRate = 1, tempVar;
    for (i = 0; i < PROCESS_NUMBER; i ++) {
        pid = fork();
        if (pid == 0) {
            id = getpid();
            printf(1, "proccess %d starts to proccessing\n", id);
            tempVar = 0;
            for (j = 0; j < busyRate; j++)
                tempVar = tempVar + 1;
            printf(1, "proccess %d waits for other process to arrive\n", id);
            barrier();
            tempVar = 0;
            for (j = 0; j < busyRate; j++)
                tempVar = tempVar + 1;
            printf(1, "proccess %d finished proccessing\n", id);
            exit();
        }
        busyRate = busyRate * 10;
    }
    for (i = 0; i < PROCESS_NUMBER; i++)
        wait();
    exit();
}


