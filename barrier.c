#include "types.h"
#include "stat.h"
#include "user.h"

#define PROCESS_NUMBER 2

int main()
{
    int pid, pid2;

    pid = fork();
    if (pid > 0)
    {
        pid2 = fork(); 
        if(pid2 == 0)
        {
            // int i ;
            // int sum =0;
            // for(i = 0; i < 90000; i++)
            //     sum += i;
            printf(1,"%d  vA %d aaaaaaaaaaaaaa\n");
            printf(1,"%d  vA %d aaaaaaaaaaaaaa\n");
            barrier();
            // sum =0;
            // for(i = 0; i < 90000; i++)
            //     sum += i;
            printf(1,"%d  vA %d bbbbbbbbbbbbbb\n");
            exit();
        }
    }
    if(pid == 0)
    {
        // int i;
        // int sum =0;
        // for(i = 0; i < 90000; i++)
        //     sum += i;
        printf(1,"%d  vA %d firessssssst\n");
        barrier();
        // sum =0;
        // for(i = 0; i < 90000; i++)
        //     sum += i;
        printf(1,"%d  vA %d sssssssssssss\n");
        exit();
    }
    wait();
    wait();
}