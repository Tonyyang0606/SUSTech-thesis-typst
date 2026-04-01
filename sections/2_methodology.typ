#import "../template/template.typ": *

= Methodology

== Overall Pipeline

ABIscope 的实现由以下模块构成：
- 种子与语料管理：`abi/origin_c/`, `abi/corpus/`
- 主流程调度：`abi/main_pipeline.py`
- 覆盖与价值评估：`abi/sac_manager.py`
- 变异生成：`abi/llm_mutator.py`
- 编译与修复：`abi/execute_and_repair.py`
- 统一模型调用：`abi/utils.py`

== Differential Execution Setup

本工作对同一批程序分别在 Linux 与 KeepOS 上执行：
- Linux 输出目录：`abi/origin_c/run_logs_linux/`
- KeepOS 输出目录：`abi/origin_c/run_logs_keepos/`
- 源程序目录：`abi/origin_c/run_logs_origin_C/`

通过样本级别对齐（相同 `prog_xxxx`）完成差分输入准备。

== LLM-based Incompatibility Attribution

为提升分析效率，本文引入 LLM Agent：
- 输入：单个 C 源码 + Linux 日志 + KeepOS 日志；
- 输出：结构化 JSON（是否不兼容、类型、关键差异、根因假设、修复建议）。

对应脚本为：`abi/analyze_keepos_abi_agent.py`。

== Threats to Validity

- fuzz 样本天然包含无效参数，需区分“样本噪声”与“内核不兼容”；
- 不同内核对未定义行为容忍度不同，可能导致误判；
- LLM 归因为启发式结论，需结合人工复核。
