# UART-ASIC
My first taped-out ASIC chip.

It is a 40-pin-pad-frame communication chip that integrated a transmitter and a receiver, implementing the UART protocol in 6-stage FSM based on 2-phase clocking, taped out by a factory in MOSIS AMI 0.5 Micron Process.

In this project, I went through the whole ASIC design flow:
* Front-end coding in Verilog (**./Modelsim**)
* Pre-simulation in Modelsim (**./Modelsim**)
* Synthesis in TCL (**./Synthesisi**)
* Post-simulation in Modelsim (**./Modelsim**)
* Layout in Encounter (**./Encounter**)
* Translate layout in Magic (**./Magic**)
* Layout verificate in Irsim (**./Irsim**)
* Generate and Flatten CIF file for fabrication (**./CIF**)
* Satisfy density rule with extra poly and metal (**./CIF**)
* CIF verificate in Irsim (**./Irsim**)
* Present results (**./ProjectPic**)

(After creating the IP Core I connectted it with the pad frame.)

