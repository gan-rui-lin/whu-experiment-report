#import "lib.typ": md

// 演示 md 函数的使用
// Demonstration of the md function usage

= md 函数使用示例

本文件演示了 lib.typ 中定义的 `md` 函数的使用方法。

== 基本 Markdown 语法

#md("
  # 这是一级标题
  
  ## 这是二级标题
  
  这是一段普通文字。这是**加粗文字**，这是*斜体文字*，这是***粗斜体文字***。
  
  - 无序列表项 1
  - 无序列表项 2
  - 无序列表项 3
  
  1. 有序列表项 1
  2. 有序列表项 2
  3. 有序列表项 3
  
  这是一个[链接](https://github.com/gan-rui-lin/whu-experiment-report)。
  
  这是行内代码：`let x = 42`
  
  这是代码块：
  ```python
  def hello():
      print('Hello, World!')
  ```
")

== 数学公式支持

#md("
  ### 行内数学公式
  
  勾股定理：$a^2 + b^2 = c^2$
  
  欧拉公式：$e^{i\pi} + 1 = 0$
  
  ### 块级数学公式
  
  定积分：
  $$
  \int_0^1 f(x) dx = F(1) - F(0)
  $$
  
  求和公式：
  $$
  \sum_{i=1}^{n} i = \frac{n(n+1)}{2}
  $$
  
  矩阵：
  $$
  A = \begin{pmatrix}
    a_{11} & a_{12} \\
    a_{21} & a_{22}
  \end{pmatrix}
  $$
")

== 混合内容

#md("
  我们可以在同一段 Markdown 中混合使用文本、**格式化**、列表和数学公式 $\alpha + \beta = \gamma$。
  
  例如，考虑斐波那契数列：
  
  - 第 $n$ 项的值：$F_n = F_{n-1} + F_{n-2}$
  - 初始条件：$F_0 = 0, F_1 = 1$
  - 通项公式：
  
  $$
  F_n = \frac{\phi^n - \psi^n}{\sqrt{5}}
  $$
  
  其中 $\phi = \frac{1+\sqrt{5}}{2}$ 是黄金比例。
")

