#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*                    first task to do                       */
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


int main()
{
        pid_t main_pid, sub_main_pid;
        int gparent_ = (int)getpid();

        main_pid = fork();
        if (main_pid < 0){perror("[~/../fork.c]: Fork Failure."); return 1;}
        else if (main_pid == 0) // son
        {
                int parent_ = (int)getpid();
                sub_main_pid = fork();
                if (sub_main_pid < 0){perror("[~/../fork.c]: Fork Failure."); return 1;}
                else if (sub_main_pid == 0) //grandson
                {
                        printf("[~/../fork.c]: Hey, I am the son of %d, also I am the grandson of: %d, my PID is: %d.\n", parent_, gparent_, (int)getpid());
                        printf("[~/../fork.c]: Grandson exited.\n");
                        exit(0);
                }else
                {
                        printf("[~/../fork.c]: Hey, I am the son of %d, my PID is: %d.\n", gparent_, parent_);
                        wait(NULL);
                        printf("[~/../fork.c]: Son exited.\n");
                }
                exit(0);
        }else
        {
                printf("[~/../fork.c]: Hey, I am the dad and the granddad, not knowing yet who my successors are.\n[~/../fork.c]: Hey, it's dad again, I forgot to mention, my PID is: %d.\n",(int) getpid());
                wait(NULL);
                printf("[~/../fork.c]: Dad exited.\n");
        }
        return 0;
}
