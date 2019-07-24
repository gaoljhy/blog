# 最耗cpu进程

## 方法一

核心指令：`ps`

`ps H -eo pid,pcpu | sort -nk2 | tail`

## 方法二

核心指令：top

top

`Shift + t`

