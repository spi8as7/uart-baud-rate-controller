#UART SYSTEM

## Project Description
  - tb-> baud_controller
  - tb2-> transmitter
  - tb3->receiver
  - tb4->system

clock -> 50	MHz 

counter = (clock * 10^6)/baud_rate * 16


1. baud_rate = 300 , counter = 10416,6666  	N=13.34
2. baud_rate = 1200 , counter =2604			    N=11.34
3. baud_rate = 4800 , counter = 651,04166     N=9.34  
4. baud_rate = 9600 , counter = 325,520833     N=8.34 
5. baud_rate = 19200 , counter = 162,7604      N=7.33    
6. baud_rate = 38400 , counter = 81,3802      N=6.33         
7. baud_rate = 57600 , counter = 54,253472    N=5.75       
8. baud_rate = 115200 , counter = 27,103       N=4.75           
