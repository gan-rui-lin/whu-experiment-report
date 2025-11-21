#import "lib.typ": *

#import "@preview/kouhu:0.1.0": kouhu


//>>> 默认字体，可通过设置可配置信息中的 font 来覆盖
#let font = (
  main: "Times New Roman",          // 英文主字体
  mono: "IBM Plex Mono",            // 英文等宽字体
  cjk: "SimSun",                    // 中文主字体
  cjk-bold: "SimHei",               // 中文加粗字体
  emph-cjk: "KaiTi",                // 中文强调字体
  math: "New Computer Modern Math", // 数学字体
  math-cjk: "Noto Serif SC",        // 数学中文字体
)

// 可配置信息
//>>> 封面信息 
#let cover_header = "武汉大学计算机学院"
#let report_title = "本科生课程设计报告"
#let title = "XXXXXXXXXXXX实验"
#let course = "XXXXXXXXXXXXXX"
#let major = "XXXXXXXXXXXXXX"
#let teacher1_name = "张三"
#let teacher1_title = "副教授"
#let teacher2_name = none                               // 若无第二指导教师则设为 none，不显示对应栏
#let teacher2_title = none                              // 若无第二指导教师则设为 none，不显示对应栏
#let student_id = "2023XXXXXXXXX"                       // 学号
#let student_name = "李四"                               // 姓名
#let year = "2025"                                      // 封面页年份
#let month = "10"                                       // 封面页月份
//>>> 报告生成选项
#let maketitle = true                                   // 是否显示封面页
#let makeabstract = true                                // 是否显示摘要页
#let makeoutline = true                                 // 是否显示目录页
#let outline-depth = 3                                  // 目录深度
#let first-line-indent = auto
#let font = font                                        // 使用默认 font，传入 none 则使用模板默认字体
#let first_level_heading_centered = true                // 一级标题是否居中，否则左对齐
#let heading_numbering = numbly("", default: "1.1 ")    // 章节编号格式，默认一级标题不编号
                                                        // 可选传入numbly格式，下面是示例：
                                                        // numbly("第 {1} 章", default: "1.1 ")
                                                        // numbly("{1}.", default: "1.1 ")
//>>> 摘要与关键词
// 摘要内容
#let abstract = [
  #kouhu(builtin-text: "zhufu", offset: 8, length: 800)
]

// 关键词数组
#let keywords = (
  kouhu(builtin-text: "simp", length: 3),
  kouhu(builtin-text: "zhufu", offset: 2, length: 3),
  kouhu(builtin-text: "zhufu", offset: 42, length: 4),
  kouhu(builtin-text: "zhufu", length: 6),
)

//>>> 不需改动 
#let teacher1 = (teacher1_name, teacher1_title)
#let teacher2 = if teacher2_name == none or teacher2_name == "" {
  none
} else {
  (teacher2_name, teacher2_title)
}

//>>> 生成报告内容 
#show: ori.with(
  cover_header: cover_header,
  report_title: report_title,
  title: title,
  course: course,
  major: major,
  teacher1: teacher1,
  teacher2: teacher2,
  student_id: student_id,
  student_name: student_name,
  year: year,
  month: month,
  maketitle: maketitle,
  makeabstract: makeabstract,
  abstract: [
    #abstract
  ],
  keywords: keywords,
  makeoutline: makeoutline,
  outline-depth: outline-depth,
  first-line-indent: first-line-indent,
  font: font,
  first_level_heading_centered: first_level_heading_centered,
  heading_numbering: heading_numbering,
)

= 分治法

#definition(title: "分治法")[
  分治法（Divide and Conquer）是一种算法设计范式，它将一个复杂的问题分解成较小的子问题，递归地解决这些子问题，然后将它们的解合并以获得原始问题的解。分治法通常包括三个步骤：

  1. *分解（Divide）*：将原始问题划分为若干个规模较小的子问题，这些子问题通常与原始问题具有相同的结构。
  
  2. *解决（Conquer）*：递归地解决这些子问题。当子问题的规模足够小（通常是基本情况）时，直接求解。
  
  3. *合并（Combine）*：将子问题的解合并成原始问题的解。

  分治法在许多经典算法中得到了广泛应用，如快速排序、归并排序、二分搜索等。它通常能够显著提高算法的效率，特别是在处理大规模数据时。
]

== 数组中的第 K 个最大元素

*问题描述*: 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。

*算法思想*: 随机给一个基准值 piviot, 容易得到大于 piviot, 等于 piviot , 小于 piviot 三部分的数量，从而将目标的“数组中的第 K 个最大元素” 所可能出现的范围缩小到三者之一并继续分支，如果在等于 piviot 的区间内则直接返回

*伪代码*:

输入：数组 num, 整数 k。

输出：第 k 个最大元素的值。

```cpp
int k_largest(vector<int> num, int k){
  return quick_sort(num, k);
}

int quick_sort(vector<int>num, int k){
  int idx = rand() % num.size();
  int x = num[idx];
  vector<int> smalls, equals, bigs;
  for (int ele in num){
    if (ele < x){
      smalls.push_back(ele);
    }else if(ele == x){
      equals.push_back(ele);
    }else{
      bigs.push_back(ele);
    }
  }
  if (k < bigs.size()){
    return quick_sort(bigs, k);
  }else if(k < bigs.size() + equals.size()){
    return equals[0];
  }else{
    return quick_sort(smalls, k);
  }
}

```

#derivation(title:"时间复杂度分析")[
  对于长度为 $N$ 的数组执行哨兵划分操作的时间复杂度为 $O(N)$。而向下分支子数组的平均长度是$N /2 $, 则平均的总时间是$N + N / 2 + ... + 1 = 2N - 1 = O(N)$
]



== 寻找峰值

*问题描述*:峰值元素是指其值严格大于左右相邻值的元素。给你一个整数数组 nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回 *任何一个峰值* 所在位置即可。假设 nums[-1] = nums[n] = -∞

*算法思想*:在边界不为峰值点时，能确定中间必有峰值点,从而在更小的区间分治，直到真正找到峰值元素。

#conclusion(title:"阿巴阿巴")[

   我认为这个算法的核心思想是利用快速排序中的划分思想，通过随机选择一个基准值，将数组划分为三部分，从而有效地缩小搜索范围，最终找到第 k 个最大元素。这种方法在平均情况下具有线性时间复杂度，适用于大规模数据的处理。

   其实是 AI 生成的结论。
]

*伪代码*:

```cpp
int findPeakElement(vector<int>& arr) {
    int n = arr.size();
    if(n == 1) return 0;
    if(arr[0] > arr[1]) return 0;
    else if(arr[n-1] > arr[n-2]) return n - 1;
    /*在边界不为峰值点时，能确定中间必有峰值点*/
    int l = 1, r = n - 2, ans = 0;
    while(l <= r){
        int m = l + (r - l) / 2;
        if(arr[m-1] > arr[m]){
            r = m - 1;
        }else if(arr[m+1] > arr[m]){
            l = m + 1;
        }else{
            ans = m;
            break;
        }
    }
    return ans;
}
```

*时间复杂度分析*: 每次二分后，待寻找的范围[l, r]都缩小一半，易知时间复杂度为$Theta (log n)$

== 逆序对数量

*问题描述*:：对于给定的一段正整数序列，逆序对就是序列中 $a_i>a_j$ 且 $i<j$ 的有序对。

*算法思想*:如果我们想要将一个序列排成从小到大有序的，那么每次划分后合并时左右子区间都是从小到大排好序的，我们只需要统计右边区间每一个数分别会与左边区间产生多少逆序对即可。由于两边分别有序，所以求解两边区间产生的逆序对数量能够很快。

*伪代码*:

输入:
第一行，一个数 $n$，表示序列中有 $n$ 个数。第二行 $n$ 个数，表示给定的序列。序列中每个数字不超过 $10^9$。

输出:输出序列中逆序对的数目

```cpp
#include<bits/stdc++.h>
using namespace std;
#define int long long

int n;
const int MAX = 5e5 + 1;
int arr[MAX]={0};
int help[MAX] = {0};
int compute();
int f(int l, int r);
int merge(int l, int m, int r);
signed main(){
    cin>>n;
    for(int i=1;i<=n;i++){
        cin>>arr[i];
    }
    cout<<compute()<<endl;
    return 0;
}
int compute(){
    return f(1, n);
}
int f(int l, int r){
    if(l==r){
        return 0;
    }
    int mid = l + (r - l) / 2;

    return f(l, mid) + f(mid+1, r) + merge(l, mid, r);
}
int merge(int l, int m, int r){
    int ans = 0;
    for(int i=m, j=r; i>=l;i--){
        while(j>=m+1&&arr[i]<=arr[j]){
            j--;
        }
        ans += j-m;
    }
    int i = l;
    int a = l, b = m+1;
    while(a<=m&&b<=r){
        help[i++] = arr[a]<=arr[b]?arr[a++]:arr[b++];
    }
    while(a<=m){
        help[i++] = arr[a++];
    }
    while(b<=r){
        help[i++] = arr[b++];
    }
    for(int i=l;i<=r;i++){
        arr[i] = help[i];
    }
    return ans;
}


```

*时间复杂度分析*：

f 函数的时间复杂度$T(n)$满足(merge 函数的执行次数为 $n$):

$
  T(n) = 2T(n/2) + n
$

求得 $T(n) = Theta(n log n)$