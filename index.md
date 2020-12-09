## Welcome to SRAM Project Page

In this project, **UVM** testbench for a simple *SRAM* isimplemented.

### Acrhitrcture
![image](image\SRAM_UVM_TB_2.png)

### Components of Test Bench
1. Transaction - Encapsulates the packet level details
2. Sequence - Generates random packets which will be driven by driver
3. Sequencer - Synchorises the sequence generation and driving of packet 
4. Driver - Drives the packet to the SRAM
5. Monitor - Monitors the input and ouput signals to and from the DUT 
6. Agent - Encapsulates _Sequncer_, _Driver_, _Monitor_ into one unit. Also, estabilishes connection between _Sequencer_ and _Driver_
7. Reference Model - Generates reference o/p values for the input signals sampled by _Monitor_.
6. Scoreboard - Compares the actual o/p with the reference o/p from _Reference Model_
5. Functional Coverage Subscriber - This is a subscriber block which sample the data collected by _Monitor_ to determine the funciton coverage.
7. Envirnonment - Encapuslates all the the lower level components into one unit. Also estabilishes connection between _Monitor_-_Scoreboard_  _Monitor_-_Functional Coverage Subscriber_
8. Test - Entry point of the test.
9. Test bench top - Connects the _DUT_ with the _Test_ through interface

### Test
