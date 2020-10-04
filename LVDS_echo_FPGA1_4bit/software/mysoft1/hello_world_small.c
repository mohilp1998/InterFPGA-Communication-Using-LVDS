
#include "sys/alt_stdio.h"
#include "system.h"
#include "io.h"
#include "stdio.h"
#include <sys/alt_irq.h>
#include "unistd.h"

#define COMPONENT_BASE LVDS_ECHO_FPGA12_4BIT_0_BASE
#define COMPONENT_IRQ LVDS_ECHO_FPGA12_4BIT_0_IRQ
#define COMPONENT_IRQ_ID LVDS_ECHO_FPGA12_4BIT_0_IRQ_INTERRUPT_CONTROLLER_ID


void sendToPeripheral (unsigned int dataToSend);
void receiveFromPeripheral ();
void read_isr(void* unused_context);
volatile int context_pointer;
int ISR_reg;
unsigned int idx_read_counter=0;
unsigned int printSend = 0;
unsigned int printRcv = 0;
unsigned int useISR = 1;

#if 0
unsigned int startFlit = 0x84000000;
unsigned int txData =0xC4000000;
#else
unsigned int startFlit = 0x98000000;
unsigned int txData =0xD8000000;
#endif

unsigned int dataToRecv_isr,dataToRecv;
unsigned const N_ITEMS_TO_SEND = 10;
unsigned int starttime,endtime;
double time_count;

int main()
{

	  alt_putstr("Hello from NIOS II!\n");
	  if (useISR){
	  //registering an interrupt
	  void *context_pointer_ptr = (void*) &context_pointer;
	  ISR_reg = alt_ic_isr_register(COMPONENT_IRQ_ID,
			  COMPONENT_IRQ,
			  read_isr,
			  context_pointer_ptr,0x0);

	  }
	starttime = IORD(CLK_COUNTER_0_BASE,0x0);
	  for(unsigned i=0; i<N_ITEMS_TO_SEND; i++)
	  	  {
	  		  sendToPeripheral(startFlit);
	  		  sendToPeripheral(txData|i);
	  	  }

	  if (useISR == 0){
		  idx_read_counter=2*N_ITEMS_TO_SEND;
		  while(idx_read_counter != 0){
			  receiveFromPeripheral();
		  	  idx_read_counter--;
		  }
		  printf("Data received %x \n",dataToRecv);
	  }
	  else{
		  while(idx_read_counter!=2*N_ITEMS_TO_SEND){
		  	  usleep(1);
		  };
		  printf("Data received %x \n",dataToRecv_isr);
	  }
	endtime =IORD(CLK_COUNTER_0_BASE,0x0);  
	  alt_putstr("All received\n");
	time_count = ((endtime - starttime) /(2*N_ITEMS_TO_SEND*4));
	printf("%d\n",starttime);
	printf("%d\n",endtime);
	printf("clock cycles to receive %d flits = %d\n",N_ITEMS_TO_SEND,time_count);
}

void sendToPeripheral (unsigned int dataToSend)
{
	int status;
	do
	{
		status = IORD(COMPONENT_BASE,0x00000000); //0x0
	}
	while (0 == (status & 0x00000001));	// check for last bit (notFull)
	IOWR(COMPONENT_BASE,0x00000001, dataToSend);
	if (printSend){
			printf("Data sent %x \n",dataToSend);
	}
}

void receiveFromPeripheral ()
{
	int status;
	do
	{
		status = IORD(COMPONENT_BASE,0x00000000);
	}
	while (0 == (status & 0x00000002));
	dataToRecv = IORD(COMPONENT_BASE,0x00000002);
	if(printRcv)
		printf("Data received %x \n",dataToRecv);
}

void read_isr (void* unused_context)
{
	//disable interrupt
//	alt_ic_irq_disable (COMPONENT_IRQ_ID,COMPONENT_IRQ);

	dataToRecv_isr = IORD(COMPONENT_BASE,0x00000002);
	if (printRcv)
		printf("Data received %x in ISR count %d \n",dataToRecv_isr,idx_read_counter);

	idx_read_counter++;

	//enable interrupt
	alt_ic_irq_enabled (COMPONENT_IRQ_ID,COMPONENT_IRQ);
}



