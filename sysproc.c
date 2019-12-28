#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int 
sys_acquireTest(void) {
  struct spinLockReentrant lk;
  initReentrantSpinlock(&lk, "splinlock");
  acquireReentrant(&lk);
  acquireReentrant(&lk);
  releaseReentrant(&lk);
  return 0;
}

#define PROCESS_NUMBER  2

int waiting_process_pids[PROCESS_NUMBER];
int ind = 0;

int wakeup_all_processes()
{
  for (int i = 0; i<PROCESS_NUMBER; i++)
    wakeup_process(waiting_process_pids[i]);
  return 0;
}


int
sys_barrier(void) {
  waiting_process_pids[ind] = myproc()->pid;
  ind++;
  sleep_process(myproc()->pid);
  cprintf("%d\n", myproc()->pid);
  if (ind == PROCESS_NUMBER)
  {
    wakeup_all_processes();
    ind = 0;
  }
  return 0;
}