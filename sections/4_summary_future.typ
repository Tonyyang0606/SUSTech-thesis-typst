#import "../template/template.typ": *

= Summary and Future Work

This paper constructs an ABI differential analysis workflow for Rust-based kernels, forming a closed loop of "sample generation — dual-platform execution — log alignment — LLM attribution". The current research primarily focuses on a single kernel subsystem (e.g., the file system and VFS-related system calls).
Future work includes:
- Expanding the testing and analysis framework to multiple kernel subsystems (such as the network stack, process management, and memory mapping);
- Further enlarging the test sample dataset to improve parameter coverage and the probability of triggering edge cases;
- Not only performing automated attribution for discovered incompatibilities, but also generating concrete fix suggestions directly for developers;
- Expanding the regression testing for other kernels, such as `kerla` and `rcore`.
