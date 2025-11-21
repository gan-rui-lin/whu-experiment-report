typst 语言简单实现的武汉大学的实验报告

forked from [typst-ori](https://github.com/hongjr03/typst-ori)

## 主要功能

### md 函数 - Markdown 渲染器

`lib.typ` 中提供了 `md` 函数，用于在 Typst 文档中渲染 Markdown 内容，并支持 LaTeX 数学公式。

**功能特点：**
- 支持 CommonMark (Markdown) 格式的完整解析和渲染
- 集成 mitex 包，支持 LaTeX 数学公式（行内公式 `$...$` 和块级公式 `$$...$$`）
- 自动将 Markdown 格式转换为 Typst 原生内容

**使用示例：**

```typst
#import "lib.typ": md

#md("
  # 标题
  
  这是一段**加粗**的文字，这是*斜体*文字。
  
  行内数学公式：$a^2 + b^2 = c^2$
  
  块级数学公式：
  $$
  \int_0^1 f(x) dx = F(1) - F(0)
  $$
")
```

更多使用示例请参考 `md-function-demo.typ` 文件。