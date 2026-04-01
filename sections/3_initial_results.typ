#import "../template/template.typ": *


= Initial Experimental Results

This chapter focuses on differential results of file-system-related syscalls (e.g., `openat`, `read`, `write`, `fcntl`, `renameat`).

== KeepOS

- In a subset of cases, KeepOS and Linux show errno mismatches (e.g., different paths leading to `EINVAL` or `EBADF`).
- There are behavioral divergences for specific flag combinations.
- Some cases exhibit “Linux fails but KeepOS succeeds” (or the reverse), suggesting syscall semantics are not fully aligned yet.

Corresponding logs can be found in `abi/origin_c/run_logs_keepos/`.

== Asterinas

- Asterinas, as another Rust-based kernel target, is used for horizontal comparison of incompatibility categories.
- For the file-system module, we focus on return-value and errno consistency of open-family and metadata-related calls.
- In the next stage, the same sample set will be executed on Asterinas to produce side-by-side statistics.
