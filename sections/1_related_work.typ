#import "../template/template.typ": *

= Background and Related Work <sec-background-related-work>
In this section, we will review the background and related work in the areas of Linux kernel development, Rust-based kernels, ABI compatibility, fuzzing and testing techniques and also the application of large language models in the software testing field. 

== Linux kernel and Rust-based kernels
Linux kernel is developed based on Unix-like kernel and it is written mostly in C. The key design of the Linux kernel is monolithic kernel@love2010linux, which means that all core os services runs in a single kernel address space and interact via direct function calls. In this design, there will be no IPC, no message passing, no internal context switches and so on. IPC and context switch in microkernel design will cost microseconds level latency, but in monolithic kernel design, the latency of the function calls can be reduced to nanoseconds level. In this case, linux kernel can provide better performance than the microkernel design.