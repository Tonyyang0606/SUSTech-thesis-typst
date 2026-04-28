#import "template/template.typ": *

// Select the active text language: Chinese(zh) or English(en)
#show: documentClass.with(lang: "zh")


#let info_en = (
  clc: "TP3",
    thesis_id: "20250328",
    udc: "004",
    title: ("ABIscope —Differential Analysis of Linux ABI Compatibility in Rust-based Kernels",),
    subtitle: "",
    author: "杨若谷",
    student_id: "12213043",
    department: "Computer Science and Engineering",
    major: "Computer Science and Technology",
    supervisor: "张殷乾",
    submit_date: datetime.today(),
)



#cover(
  en: true,
  anonymous:false,
  info: info_en,
)

// Please disable EN declaration form to match Word template in Chinese
// Do this by commenting out the following invocation
#declare(
  en: true,
  anonymous: false,
  print_date: none
)

#set page(numbering: "I")
#counter(page).update(1)


#let keywords_en = (
  "Linux Kernel",
  "Rust",
  "ABI Compatibility",
  "LLMs",
  "Syzkaller"
)

#let keywords_zh = (
  "Linux内核",
  "Rust",
  "ABI兼容性",
  "大语言模型",
  "Syzkaller"
)

#let abstract_body_en = [
 Linux kernel is the core component of the Linux operating system, responsible for providing essential services and managing hardware resources. With the emergence of Rust as a systems programming language, there has been growing interest in using Rust for kernel development due to its memory safety features. However, ensuring ABI (Application Binary Interface) Compatibility between Rust-based kernels and existing Linux kernel modules is crucial for the successful adoption of Rust in kernel development. Existing tools like Syzkaller target at finding bugs in the Linux kernel, but they do not specifically address the challenges of ABI Compatibility in Rust-based kernels. In this thesis, we present ABIscope, a novel tool designed to generate user-space test cases for differential analysis of Linux ABI Compatibility in Rust-based kernels. ABIscope makes uses of LLMs to generate test cases. We evaluate ABIscope on Rust-based kernels and demonstrate its effectiveness in identifying ABI Compatibility issues, providing valuable insights for developers and researchers in the field of kernel development.
]

#let abstract_body_zh = [
#par(first-line-indent: 2em)[Linux 内核是操作系统的核心组件，负责提供系统基础服务并管理硬件资源。近年来，Rust 语言由于其内存安全和线程安全的特性，在内核开发中的应用越来越受关注。然而，在现有 Linux 生态下，采用 Rust 重写或开发的内核模块必须保证与传统 C 语言内核之间的 ABI（应用程序二进制接口）完全兼容。由于内核接口涉及复杂的系统调用和底层数据结构，即便没有发生崩溃，也可能产生细微的行为差异。现有的内核模糊测试工具（例如 Syzkaller）主要面向崩溃挖掘和漏洞检测，缺乏对跨内核 ABI 兼容性的直接支持。]
#par(first-line-indent: 2em)[针对上述问题，本文提出了 ABIscope——一种基于大语言模型（LLM）驱动的用户态测试用例生成与差分分析框架。我们提出了一种包含种子初始化、大模型结构与参数变异、差分执行验证以及覆盖率引导选择的闭环工作流。具体而言，本方法不依赖于内核内嵌插桩，而是设计了系统调用参数覆盖率（SAC）机制，从变异代码的静态特征和运行时的副作用等多维度进行反馈引导。]
#par(first-line-indent: 2em)[通过对比测试标准 C 语言内核与基于 Rust 构建的新型内核，ABIscope 能够自动化生成涵盖大量边界条件（Edge Cases）的系统调用序列，并结构化地分析两者在返回值、错误码及文件系统副作用上的差异。实验结果表明，ABIscope 能够有效定位并归因 ABI 不兼容问题，为未来基于 Rust 的系统内核开发和生态平滑过渡提供了有力工具和方法支持。]
]

#abstract(
  show_title: true,
  prefer_en_header: true,
  en: true, // Use `true` if you want your EN abstract precede ZH abstract
  anonymous: false,
  info_en: info_en,
  keywords_en: keywords_en,
  keywords_zh: keywords_zh,
  body_en: abstract_body_en,
  body_zh: abstract_body_zh,
)

#content()

#set page(numbering: "1")
#counter(page).update(1)

#include "sections/1_introduction.typ"

#include "sections/1_related_work.typ"

#include "sections/2_methodology.typ"

#include "sections/3_initial_results.typ"

#include "sections/4_summary_future.typ"

#set heading(numbering: none)

#set text(lang: "en")

#references(show_both: false)



