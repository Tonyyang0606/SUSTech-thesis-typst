#import "../template/template.typ": *

= Summary and Future Work

本文构建了面向 Rust-based kernel 的 ABI 差分分析流程，形成了“样本生成—双平台执行—日志对齐—LLM 归因”的闭环。

未来工作包括：
- 扩展到更多 syscall 家族（网络、进程管理、内存映射）；
- 建立不兼容严重度评分与修复优先级机制；
- 引入回归测试集，将已修复案例长期纳入 CI。
