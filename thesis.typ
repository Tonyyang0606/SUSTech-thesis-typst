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

#let abstract_body_en = [
 Linux kernel is the core component of the Linux operating system, responsible for providing essential services and managing hardware resources. With the emergence of Rust as a systems programming language, there has been growing interest in using Rust for kernel development due to its memory safety features. However, ensuring ABI (Application Binary Interface) Compatibility between Rust-based kernels and existing Linux kernel modules is crucial for the successful adoption of Rust in kernel development. Existing tools like Syzkaller target at finding bugs in the Linux kernel, but they do not specifically address the challenges of ABI Compatibility in Rust-based kernels. In this thesis, we present ABIscope, a novel tool designed to generate user-space test cases for differential analysis of Linux ABI Compatibility in Rust-based kernels. ABIscope makes uses of LLMs to generate test cases. We evaluate ABIscope on Rust-based kernels and demonstrate its effectiveness in identifying ABI Compatibility issues, providing valuable insights for developers and researchers in the field of kernel development.
]

#abstract(
  show_title: true,
  prefer_en_header: true
  ,
  en: true, // Use `true` if you want your EN abstract precede ZH abstract
  anonymous: false,
  info_en: info_en,
  keywords_en: keywords_en,
  body_en: abstract_body_en,
)

#content()

#set page(numbering: "1")
#counter(page).update(1)

#include "sections/1_introduction.typ"

#include "sections/2_methodology.typ"

#include "sections/3_initial_results.typ"

#include "sections/4_discussion.typ"

#include "sections/5_summary_future.typ"

#set heading(numbering: none)

#set text(lang: "en")

#references(show_both: false)

#appendix(show_both: false)

#include "sections/appendix.typ"
