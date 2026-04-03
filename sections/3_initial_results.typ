#import "../template/template.typ": *


= Initial Experimental Results

This chapter focuses on the differential results of file-system-related system calls (e.g., `openat`, `read`, `write`, `fcntl`, `renameat`) when comparing native Linux with two Rust-based OS kernels: KeepOS and Asterinas. We ran an identical corpus of 500 generated C programs, built natively on Linux, and executed them across all three operating environments with sandboxing.

== Overall Compatibility Statistics

Both KeepOS and Asterinas demonstrate highly analogous behavior as shown by the number of incompatible test cases out of the 500 executions.

#align(center)[
#table(
  columns: (auto, auto, auto),
  align: center,
  [*Metric*], [*KeepOS*], [*Asterinas*],
  [Total Analyzed Cases], [500], [500],
  [Incompatible Cases], [81 ], [80 ],

)
]

The distribution of incompatibility types is strongly correlated between the two systems. The most frequent issues are the divergence of return error codes (`errno_diff`) and behavioral differences (`behavior_diff`).

#align(center)[
#table(
  columns: (1fr, auto, auto),
  align: center,
  [*Incompatibility Type*], [*KeepOS Cases*], [*Asterinas Cases*],
  [`errno_diff`], [79], [76],
  [`behavior_diff`], [33], [32],
  [`ret_diff`], [26], [25],
  [`unexpected_failure`], [21], [20],
  [`unexpected_success`], [21], [15],
  [`missing_syscall`], [11], [10]
)
]

== Major Incompatibility Categories



=== Missing Syscall Support (`openat2`)
Across 10 test cases, both KeepOS and Asterinas return `ENOSYS` (38) for the `openat2` syscall (syscall 437). Linux, depending on the test arguments, typically returns `EINVAL` (22) if the struct size or flag combinations are malformed. This highlights a gap indicating neither system currently supports the Linux 5.6+ `openat2` ABI endpoint.

=== `fcntl` Errno Precedence Mismatch (`EINVAL` vs `EBADF`)
A highly frequent defect (affecting 31 cases in KeepOS and 22 in Asterinas) revolves around `fcntl` argument validation priority. When an operation is performed on an invalid file descriptor (e.g., `-1`) and an unsupported command is passed, the Linux VFS checks the file descriptor logic first, returning `EBADF` (9). Conversely, KeepOS and Asterinas evaluate the `fcntl` command first and reject it as an unsupported operation, returning `EINVAL` (22).

=== `O_PATH` Semantics and Operation Filtering
Linux enforces strict semantics for file descriptors instantiated with the `O_PATH` flag: most operations (including many `fcntl` commands) are invalid on them and immediately yield `EBADF`. The test results reveal 11 failures in KeepOS and 9 in Asterinas where operations on `O_PATH` descriptors behaved differently (yielding `EINVAL` instead of the required `EBADF` or proceeding successfully). The Rust-based kernels currently fail to maintain identical filtering boundaries.

=== Validation Deficits (`unexpected_success`)
There is looser enforcement of access mode flags in the new kernels. While Linux rigorously verifies the `flags` parameter (e.g., bits mapping to `O_ACCMODE` forming invalid states on specific requests), Asterinas and KeepOS sometimes accept and quietly overlook invalid flags. Notably, Asterinas handles invalid memory pointers and boundary checks mildly tighter than KeepOS (yielding 15 unexpected successes vs KeepOS's 21), but both diverge from Linux's rigorous argument validation.