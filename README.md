# ExpasitOS
Working on making a simple operating system to get experience with it. 
<br>
This project is divided into two sections, V1 which is the pre unix development and V2, which is developing on a unix machine.

<h5>V1</h5>
This project was going well for a while. The issues started arising when trying to combine an object file from a .c file with the assembly code. This just wouldln't work due to not having the correct compiler options. I could enter the kernel, but leaving always threw an error which is not idea, especially this early. The project was put on hold until another idea came up, which was developing on a unix machine since they support the 'elf' file format. This project uses bochs to emulate the code. Running script.cmd will compile and run the emulator quickly so that is the starting point for this project.
<h5>V2</h5>
V2 is basically starting from scratch but quickly implementing the code from V1. I installed WSL (windows subsystem for linux) to allow me to be on the same environment as the tutorial code I was following from. The main differences I have found with the V1 code and V2 code is converting characters to integers in asm code. For example, '\0' in windows asm is equal to 0 as an integer, but on the unix machine, it is just '\' and the extra '0' throws a compiler warning. So I will have to check all of the code and verify it compiles well, but we should be back to 32 bits and a kernel soon. Also in V2 is the use of QEMU rather than bochs. After doing lots of reading, QEMU seems better fit for my situation so I will be using that emulator from now on.


<h4>Resources</h4>
Here is a list of resourcse I am using for helping with development. This is a non-exhaustive list.<br>
https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf <br>
https://web.stanford.edu/class/cs107/resources/x86-64-reference.pdf <br>
https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf <br>
https://yassinebridi.github.io/asm-docs/8086_bios_and_dos_interrupts.html <br>
https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html <br>
https://flint.cs.yale.edu/cs421/papers/x86-asm/x86-registers.png <br>
https://wiki.osdev.org/Main_Page <br>
