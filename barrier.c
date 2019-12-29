#include "types.h"
#include "stat.h"
#include "user.h"

#define PROCESS_NUMBER 5

int main()
{
    int pid, i, j, busyRate = 1, tempVar;
    for (i = 0; i < PROCESS_NUMBER; i ++) {
        pid = fork();
        if (pid == 0) {
            printf(1, "%dth proccess starts to proccessing\n", i+1);
            tempVar = 0;
            for (j = 0; j < busyRate; j++)
                tempVar = tempVar + 1;
            printf(1, "%dth proccess waits for other process to arrive\n", i+1);
            barrier(PROCESS_NUMBER);
            tempVar = 0;
            for (j = 0; j < busyRate; j++)
                tempVar = tempVar + 1;
            printf(1, "%dth proccess finished proccessing\n", i+1);
            exit();
        }
        busyRate = busyRate * 10;
    }
    for (i = 0; i < PROCESS_NUMBER; i++)
        wait();
    exit();
}


