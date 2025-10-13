#import "@preview/numbly:0.1.0": numbly
#import "@preview/tablem:0.2.0": tablem, three-line-table
#import "@preview/mitex:0.2.5": *
#import "@preview/cmarker:0.1.2": render as cmarker-render
#import "@preview/theorion:0.3.2": *
#import "@preview/zebraw:0.4.4": *
#import cosmos.fancy: *

#let md = cmarker-render.with(math: mitex)

// 中文报告常用字体与配色）
#let default-font = (
  main: "Times New Roman",
  mono: "IBM Plex Mono",
  cjk: "SimSun",
  cjk-bold: "SimHei",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)
#let cn-primary-color = rgb("#1f2020")
#let cn-accent-color = rgb("#2e8b57")
#let cn-code-bg = rgb("#FFFFFF")

// 数学定义
#let prox = math.op("prox")
#let proj = math.op("proj")
#let argmax = math.op("argmax", limits: true)
#let argmin = math.op("argmin", limits: true)

#let cover(
  title: "XXX系统总体设计与实现",
  major: "计算机科学与技术",
  course: "嵌入式系统设计",
  teacher1: ("张三", "副教授"),
  teacher2: none, // 设为 none 可隐藏教师二
  student_id: "2020XXXXXXX",
  student_name: "王五",
  year: "二五",
  month: "十",
) = {
  // 构建 rows 列表
  let rows = ([
    #set text(font: "SimSun", size: 15pt)
    专 业 名 称 ：
  ], [
    #set text(font: "SimSun", size: 15pt)
    #major
  ], [
    #set text(font: "SimSun", size: 15pt)
    课 程 名 称 ：
  ], [
    #set text(font: "SimSun", size: 15pt)
    #course
  ], [
    #set text(font: "SimSun", size: 15pt)
    指 导 教 师 一：
  ], [
    #set text(font: "SimSun", size: 15pt)
    #teacher1.at(0) #h(1em) #teacher1.at(1)
  ],)

  if teacher2 != none and teacher2.at(0) != "" and teacher2.at(1) != "" {
    rows += ([
      #set text(font: "SimSun", size: 15pt)
      指 导 教 师 二：
    ], [
      #set text(font: "SimSun", size: 15pt)
      #teacher2.at(0) #h(1em) #teacher2.at(1)
    ],)
  }

  rows += ([
    #set text(font: "SimSun", size: 15pt)
    学 生 学 号 ：
  ], [
    #set text(font: "SimSun", size: 15pt)
    #student_id
  ], [
    #set text(font: "SimSun", size: 15pt)
    学 生 姓 名 ：
  ], [
    #set text(font: "SimSun", size: 15pt)
    #student_name
  ],)

  box(width: 100%, height: 100%)[
    // 顶部学校信息
    #align(center)[
      #set text(font: "SimSun", size: 26pt)
      武汉大学计算机学院
    ]
    #v(1.2em)
    #align(center)[
      #set text(font: "SimSun", size: 26pt)
      本科生课程设计报告
    ]

    #v(3em)

    // 主标题
    #align(center)[
      #set text(font: "SimHei", size: 22pt)
      #set par(leading: 32pt)
      #title
    ]

    #v(5em)

    // 信息栏
    #align(center)[
      #grid(
        columns: (auto, auto),
        row-gutter: 30pt,
        align: (right, left),
        ..rows, // 动态展开，不会出现空白行
      )
    ]

    #v(6em)

    // 日期
    #align(center)[
      #set text(font: "SimSun", size: 15pt)
      二〇#year 年 #month 月
    ]
  ]
}

#let ori(
  media: "print",
  theme: "light",
  size: 10.5pt,
  screen-size: 10.5pt,
  title: none,
  major: "计算机科学与技术",
  course: none,
  teacher1: none,
  teacher2: none,
  student_id: "2023XXXXXXXXX",
  student_name: none,
  year: "二五",
  month: 6,
  author: none,
  subject: none,
  font: default-font,
  lang: "zh",
  region: "cn",
  first-line-indent: (amount: 0pt, all: false),
  maketitle: false,
  makeoutline: false,
  outline-depth: 2,
  body,
) = context {
  assert(media == "screen" or media == "print", message: "media must be 'screen' or 'print'")
  assert(theme == "light" or theme == "dark", message: "theme must be 'light' or 'dark'")
  let page-margin = if media == "screen" { (x: 35pt, y: 35pt) } else { auto }
  let text-size = if media == "screen" { screen-size } else { size }
  let bg-color = if theme == "dark" { rgb("#1f1f1f") } else { rgb("#ffffff") }
  let text-color = if theme == "dark" { rgb("#ffffff") } else { rgb("#000000") }
  let raw-color = if theme == "dark" { rgb("#27292c") } else { rgb("#f0f0f0") }

  // 收集封面信息
  let cover_info = (
    title: title,
    major: major,
    course: course,
    teacher1: teacher1, // (name, title)
    teacher2: teacher2, // (name, title)
    student_id: student_id,
    student_name: student_name,
    year: year,
    month: month,
  )

  // 正文：拉丁字母用 Times New Roman，CJK 用宋体
  set text(font: ((name: font.main, covers: "latin-in-cjk"), font.cjk), size: 12pt)
  set par(leading: 11pt) // 12pt + 11pt = 23pt 基线距
  // emph：拉丁用 TNR，中文用楷体；中文稍微放大一点，避免显小
  show emph: it => {
    set text(font: ((name: font.main, covers: "latin-in-cjk"), font.emph-cjk))
    // 仅对中文（Han script）放大 ~6%
    show regex("\\p{script=Han}"): set text(size: 1.06em)
    it
  }
  show raw: set text(font: ((name: font.mono, covers: "latin-in-cjk"), font.cjk))
  show math.equation: it => {
    set text(font: font.math)
    show regex("\p{script=Han}"): set text(font: font.math-cjk)
    it
  }

  // 强调：拉丁保留 TNR，CJK 使用黑体，并加粗
  show strong: it => {
    set text(font: ((name: font.main, covers: "latin-in-cjk"), font.cjk-bold), weight: "bold", fill: cn-primary-color)
    it
  }

  // 标题样式
  show heading: it => {
    show h.where(amount: 0.3em): none
    it
  }
  show heading: set block(spacing: 1.2em)

  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(font: font.cjk-bold, size: 18pt)
    #align(center)[#it]
    #v(11.5pt)
  ]

  // 二级标题：黑体 四号（14pt）
  show heading.where(level: 2): it => [
    #set text(font: font.cjk-bold, size: 14pt)
    #it
  ]

  // 三级标题 黑体 小四号
  show heading.where(level: 3): it => [
    #set text(font: font.cjk-bold, size: 12pt)
    #it
  ]
  // 四级标题 黑体 小四号
  show heading.where(level: 4): it => [
    #set text(font: font.cjk-bold, size: 12pt)
    #it
  ]
  // 代码块样式
  show raw.where(block: false): body => box(fill: raw-color, inset: (x: 3pt, y: 0pt), outset: (x: 0pt, y: 3pt), radius: 2pt, {
    set par(justify: false)
    body
  })
  show raw.where(block: true): zebraw
  show raw.where(block: true): it => v(-1em) + it

  // 链接样式
  show link: it => {
    if type(it.dest) == str {
      set text(fill: blue)
      it
    } else { it }
  }

  // 表格样式
  show figure.where(kind: table): set figure.caption(position: top)

  // 列表样式
  set list(indent: 2em)
  show list: it => { set list(indent: 6pt); it }
  set enum(indent: 2em)
  show enum: it => { set enum(indent: 6pt); it }
  set enum(numbering: numbly("{1:1}.", "{2:1})", "{3:a}."), full: true)

  // 引用样式
  set bibliography(style: "ieee")

  // 文档基本信息
  set document(title: title, author: if type(author) == str { author } else { () }, date: none)

  // 页面计数器
  counter(page).update(1)

  // 页面设置
  set page(paper: "a4", header: if here().page() == 1 and maketitle { none } else {
    counter(footnote).update(0)
  }, fill: bg-color, numbering: "1", margin: page-margin)

  // 标题页
  if maketitle {
    // 使用 cover_info 渲染封面（无需手动调用 cover(...)）
    let cv = cover_info
    cover(
      title: if cv.title != none { cv.title } else { "" },
      major: if cv.major != none { cv.major } else { "" },
      course: if cv.course != none { cv.course } else { "" },
      teacher1: if cv.teacher1 != none { cv.teacher1 } else { ("", "") },
      teacher2: if cv.teacher2 != none { cv.teacher2 } else { ("", "") },
      student_id: if cv.student_id != none { cv.student_id } else { "" },
      student_name: if cv.student_name != none { cv.student_name } else { "" },
      year: if cv.year != none { cv.year } else { 0 },
      month: if cv.month != none { cv.month } else { 0 },
    )
    pagebreak()
  }

  // 目录
  if makeoutline {
    // 覆盖可能由外部包注入的目录标题（如"Contents"）
    show outline: it => it
    // 目录标题：黑体小二
    align(center)[
      #set text(font: font.cjk-bold, size: 18pt)
      目录
    ]
    v(0.8em)

    // 目录样式：章 黑体四号；其他 小四宋体
    // 先设默认（其他）
    show outline.entry: it => {
      // 按层级动态设置字号和粗细
      let size = if it.level == 1 { 14pt } else { 12pt }
      let font_chosen = if it.level == 1 { font.cjk-bold } else { font.cjk }
      set text(font: font_chosen, size: size)
      it
    }
    show outline.entry: set block(spacing: 1em)
    outline(depth: outline-depth, indent: 2em, title: none)
    pagebreak(weak: true)
  }

  // 段落样式
  set par(justify: true, first-line-indent: if first-line-indent == auto {
    (amount: 2em, all: true)
  } else {
    first-line-indent
  })

  // 定理环境
  show: show-theorion

  body
}
