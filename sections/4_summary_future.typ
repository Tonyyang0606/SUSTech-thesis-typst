#import "../template/template.typ": *

= Summary and Future Work

== Summary

This thesis presents ABIscope, a feedback-driven framework for automatically generating and evaluating user-space test cases that expose ABI incompatibilities between Linux and Rust-based kernels. The core pipeline integrates LLM-based seed translation and mutation, coverage-guided selection via the SAC metric, differential execution, and LLM-assisted attribution into a closed feedback loop that requires no kernel instrumentation.

=== Contributions and Research Significance

To the best of our knowledge, ABIscope is the first framework to apply LLM-guided mutation for systematic discovery of ABI incompatibilities between Linux and Rust-based kernels. Prior work on kernel fuzzing (e.g., Syzkaller) targets crash-inducing bugs and is not designed to evaluate the correctness of return values, errno codes, or side-effects; existing ABI analysis tools (e.g., SCML) perform only static flag-matching and do not execute programs to observe dynamic behavior. ABIscope fills this gap.

Its two core contributions are: (1) SAC (System-call Argument Coverage), a semantics-oriented feedback metric that quantifies argument-space diversity without kernel instrumentation, providing a principled selection signal suited to ABI compatibility analysis; and (2) a closed-loop pipeline that combines LLM-based mutation with differential execution and automated attribution, demonstrating that ABI incompatibilities in a real-world Rust-based kernel can be discovered at scale without manual effort.

The broader research significance lies in showing that the gap between a kernel claiming Linux ABI compatibility and one that actually achieves it is both measurable and substantial. ABIscope provides a practical, reusable methodology for kernel developers to continuously verify and narrow this gap as their implementations mature.

=== Limitations

Despite these contributions, three limitations should be acknowledged.

First, all experiments target a single Rust-based kernel, Asterinas. While Asterinas is a representative and actively maintained Linux ABI-compatible kernel, conclusions may not generalise to other Rust-based kernels such as Kerla or rCore. The results may differ because of different syscall implementation and maturity levels.

Second, the evaluation covers only three syscall subsystems: filesystem operations, I/O management, and memory management. Important subsystems including networking (`socket`/`bind`/`sendmsg`), inter-process communication (pipes, signals, shared memory), and device-driver interfaces remain untested. ABI gaps in those areas may be equally or more severe.

Third, all generated test programs are single-threaded and stateless across executions. Concurrency-related ABI issues such as race conditions in fd allocation, atomic behavior differences in `futex`, or scheduler-dependent errno sequencing cannot be captured by the current framework, since the differential execution model assumes deterministic output for the same input@difference_testing.

== Future Work
The limitations above suggest several directions for future work.

The most immediate direction is to expand the kernel set. Adding Kerla and rCore as additional targets would help determine whether the incompatibilities we observe are specific to Asterinas or reflect broader patterns in Rust-based reimplementations of the Linux ABI. We expect that some of the IO-related findings may carry over, while the file system behavior differences may be less consistent across implementations.

A second direction is to extend coverage beyond the three domains studied in this work. Networking and IPC syscalls can, in principle, be supported within the same SAC and mutation pipeline. However, they require additional flag dictionaries and new templates for socket addresses and message buffers. While this extension does not appear conceptually difficult, it is likely to involve substantial engineering effort.

Concurrency presents a more challenging and interesting direction. The current framework executes each test in a single-threaded setting, which means that issues dependent on interleavings, such as lock ordering problems, missed memory barrier effects, or inconsistent updates to file descriptor tables, are not captured. Extending differential comparison to multi-threaded execution traces would require defining equivalence between executions where ordering is no longer fixed, which remains an open problem.

Finally, the current system uses the LLM only for input generation and mutation. It may also be possible to use the model to suggest fixes for confirmed incompatibilities, given divergence traces and relevant source context. However, it remains unclear whether such suggestions would be practically useful, or whether they would simply produce plausible but superficial patches that pass the existing test suite. This would need careful evaluation before any stronger claims could be made.