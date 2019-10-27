# 使用readr进行数据导入

readr是tidyverse的核心包之一，readr是较新的进行数据导入的包，相比就的导入函数和自带的数据导入函数有不少优势，不少地方还在使用旧的方法导入或者读取数据。

旧的方法目前还是比较通用，一般还不需要加载额外的包，都要知道，就不对比了，因为能力不足。


```R
# 加载包
library(tidyverse)
```

    ─ [1mAttaching packages[22m ──────────────────── tidyverse 1.2.1 ─
    [32m✔[39m [34mggplot2[39m 3.2.1     [32m✔[39m [34mpurrr  [39m 0.3.2
    [32m✔[39m [34mtibble [39m 2.1.3     [32m✔[39m [34mdplyr  [39m 0.8.3
    [32m✔[39m [34mtidyr  [39m 1.0.0     [32m✔[39m [34mstringr[39m 1.4.0
    [32m✔[39m [34mreadr  [39m 1.3.1     [32m✔[39m [34mforcats[39m 0.4.0
    ─ [1mConflicts[22m ───────────────────── tidyverse_conflicts() ─
    [31m✖[39m [34mdplyr[39m::[32mfilter()[39m masks [34mstats[39m::filter()
    [31m✖[39m [34mdplyr[39m::[32mlag()[39m    masks [34mstats[39m::lag()


## 摘要

readr的多数函数用于将平面文件转换为数据框

read_csv()：读取逗号分割的文件，

read_csv2()：读取分号分割的文件，

read_tsv()：读取制表符分割的文件，

read_delim()：读取任意分隔符的文件

read_fwf()：读取固定宽度的文件，

其他参考书或者帮助

这些函数用法类似，这里主要介绍read_csv()函数，逗号分割的CSV文件常用

## read_csv()


```R
# 让我们用read_csv()函数读取本地文件
heights <- read_csv("data/heights.csv") 
# read_csv()会打印数据说明，非常有用
heights %>% head()
```

    Parsed with column specification:
    cols(
      earn = [32mcol_double()[39m,
      height = [32mcol_double()[39m,
      sex = [31mcol_character()[39m,
      ed = [32mcol_double()[39m,
      age = [32mcol_double()[39m,
      race = [31mcol_character()[39m
    )



<table>
<caption>A tibble: 6 × 6</caption>
<thead>
	<tr><th scope=col>earn</th><th scope=col>height</th><th scope=col>sex</th><th scope=col>ed</th><th scope=col>age</th><th scope=col>race</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>50000</td><td>74.42444</td><td>male  </td><td>16</td><td>45</td><td>white</td></tr>
	<tr><td>60000</td><td>65.53754</td><td>female</td><td>16</td><td>58</td><td>white</td></tr>
	<tr><td>30000</td><td>63.62920</td><td>female</td><td>16</td><td>29</td><td>white</td></tr>
	<tr><td>50000</td><td>63.10856</td><td>female</td><td>16</td><td>91</td><td>other</td></tr>
	<tr><td>51000</td><td>63.40248</td><td>female</td><td>17</td><td>39</td><td>white</td></tr>
	<tr><td> 9000</td><td>64.39951</td><td>female</td><td>15</td><td>26</td><td>white</td></tr>
</tbody>
</table>




```R
# 再看读取行内CSV的例子
read_csv("a,b,c
1,2,3
4,5,6")
```


<table>
<caption>A spec_tbl_df: 2 × 3</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>3</td></tr>
	<tr><td>4</td><td>5</td><td>6</td></tr>
</tbody>
</table>




```R
# 以上两个例子read_csv()函数都使用第一行作为列名称
# 可以使用skip = n　来跳过前n行
# 或者使用comment = "#"丢弃以"#"开头的行

read_csv("The first line of metadata
The second line of metadata
x,y,z
1,2,3", 
skip = 2)


read_csv("# A comment I want to skip
x,y,z
1,2,3",
comment = "#")
```


<table>
<caption>A spec_tbl_df: 1 × 3</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th><th scope=col>z</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>3</td></tr>
</tbody>
</table>




<table>
<caption>A spec_tbl_df: 1 × 3</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th><th scope=col>z</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>3</td></tr>
</tbody>
</table>




```R
# 若数据没有列名称，可以使用col_names = F 
read_csv("1,2,3\n4,5,6", col_names = F)
# "\n"记住是换行即可
# 或者向col_names传递一个向量作为列名称
read_csv("1,2,3\n4,5,6", col_names =  c("x","y","z"))
```


<table>
<caption>A spec_tbl_df: 2 × 3</caption>
<thead>
	<tr><th scope=col>X1</th><th scope=col>X2</th><th scope=col>X3</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>3</td></tr>
	<tr><td>4</td><td>5</td><td>6</td></tr>
</tbody>
</table>




<table>
<caption>A spec_tbl_df: 2 × 3</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th><th scope=col>z</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>3</td></tr>
	<tr><td>4</td><td>5</td><td>6</td></tr>
</tbody>
</table>




```R
# 在读取真实数据是的重要选项是na，设定使用哪个值作为缺失值
read_csv("a,b,c\n1,2,.", na = ".")
```


<table>
<caption>A spec_tbl_df: 1 × 3</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;lgl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>NA</td></tr>
</tbody>
</table>



### 更多参数和用法查看帮助

R基础包中的函数会继承操作系统的功能并依赖环境变量，因此在你电脑上正常运行的代码在导入他人计算机时不一定能正常运行

### 练习


```R
# 读取又"|"分隔的文件
split_bar <- "x|y|z\n1|2|3\n4|5|6"
read_delim(split_bar, delim = "|")

```


<table>
<caption>A spec_tbl_df: 2 × 3</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th><th scope=col>z</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>3</td></tr>
	<tr><td>4</td><td>5</td><td>6</td></tr>
</tbody>
</table>




```R
# 读取字符串中包含逗号的CSV文件
test_char <- "x,y\n1,'a,b'"
read_csv(test_char, quote = "''")
read_csv(test_char)# warnning读错
read_delim(test_char, delim = ",", quote = "'")

```


<table>
<caption>A spec_tbl_df: 1 × 2</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>a,b</td></tr>
</tbody>
</table>



    Warning message:
    “1 parsing failure.
    row col  expected    actual         file
      1  -- 2 columns 3 columns literal data
    ”


<table>
<caption>A spec_tbl_df: 1 × 2</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>'a</td></tr>
</tbody>
</table>




<table>
<caption>A spec_tbl_df: 1 × 2</caption>
<thead>
	<tr><th scope=col>x</th><th scope=col>y</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>a,b</td></tr>
</tbody>
</table>




```R
# 看几个错误，看和自己想的结果一样不一样
read_csv("a,b\n1,2,3\n4,5,6")
read_csv("a,b,c\n1,2\n1,2,3,4")
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3")
```

    Warning message:
    “2 parsing failures.
    row col  expected    actual         file
      1  -- 2 columns 3 columns literal data
      2  -- 2 columns 3 columns literal data
    ”


<table>
<caption>A spec_tbl_df: 2 × 2</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td></tr>
	<tr><td>4</td><td>5</td></tr>
</tbody>
</table>



    Warning message:
    “2 parsing failures.
    row col  expected    actual         file
      1  -- 3 columns 2 columns literal data
      2  -- 3 columns 4 columns literal data
    ”


<table>
<caption>A spec_tbl_df: 2 × 3</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>NA</td></tr>
	<tr><td>1</td><td>2</td><td> 3</td></tr>
</tbody>
</table>



    Warning message:
    “2 parsing failures.
    row col                     expected    actual         file
      1  a  closing quote at end of file           literal data
      1  -- 2 columns                    1 columns literal data
    ”


<table>
<caption>A spec_tbl_df: 1 × 2</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>NA</td></tr>
</tbody>
</table>




<table>
<caption>A spec_tbl_df: 2 × 2</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td></tr>
	<tr><td>a</td><td>b</td></tr>
</tbody>
</table>




<table>
<caption>A spec_tbl_df: 1 × 1</caption>
<thead>
	<tr><th scope=col>a;b</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1;3</td></tr>
</tbody>
</table>



## 解析向量

这一部分觉得不需要可以跳过，讲的是读取函数怎么读取的


```R
# parse_*()函数族，接受一个字符向量并返回一个特定向量
parse_logical(c("TRUE", "FALSE", "NA")) %>% str()

parse_integer(c("1", "2", "3")) %>% str()

parse_date(c("2010-02-03", "1997-05-12")) %>% str()
```

     logi [1:3] TRUE FALSE NA
     int [1:3] 1 2 3
     Date[1:2], format: "2010-02-03" "1997-05-12"



```R
# 指定缺失值
parse_integer(c("1", "123", ".", "234"), na = ".")

# warnning
parse_integer(c("123", "234", "abc", "123.45"))
# 整数读取函数将字符串和浮点数作为NA读入
```


<ol class=list-inline>
	<li>1</li>
	<li>123</li>
	<li>&lt;NA&gt;</li>
	<li>234</li>
</ol>



    Warning message:
    “2 parsing failures.
    row col               expected actual
      3  -- an integer                abc
      4  -- no trailing characters    .45
    ”


<ol class=list-inline>
	<li>123</li>
	<li>234</li>
	<li>&lt;NA&gt;</li>
	<li>&lt;NA&gt;</li>
</ol>




```R
x <- parse_integer(c("123", "234", "abc", "123.45"))
x
# 使用problems()获取失败的信息集合
problems(x)
```

    Warning message:
    “2 parsing failures.
    row col               expected actual
      3  -- an integer                abc
      4  -- no trailing characters    .45
    ”


<ol class=list-inline>
	<li>123</li>
	<li>234</li>
	<li>&lt;NA&gt;</li>
	<li>&lt;NA&gt;</li>
</ol>




<table>
<caption>A tibble: 2 × 4</caption>
<thead>
	<tr><th scope=col>row</th><th scope=col>col</th><th scope=col>expected</th><th scope=col>actual</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>3</td><td>NA</td><td>an integer            </td><td>abc</td></tr>
	<tr><td>4</td><td>NA</td><td>no trailing characters</td><td>.45</td></tr>
</tbody>
</table>



重要的8种解析函数

- parse_logical()和parse_integer()函数分别解析逻辑值和整数。因为这两个解析函数基本不会出现问题，所以我们不再进行更多介绍。

- parse_double()是严格的数值型解析函数，parse_number()则是灵活的数值型解析函数。这两个函数要比你预想的更复杂，因为世界各地书写数值的方式不尽相同。

- parse_character()函数似乎太过简单，甚至没必要存在。但一个棘手的问题使得这个函数变得非常重要：字符编码。

- parse_factor()函数可以创建因子，R使用这种数据结构来表示分类变量，该变量具有固定数目的已知值。

- parse_datetime()、parse_date()和parse_time()函数可以解析不同类型的日期和时间。它们是最复杂的，因为有太多不同的日期书写形式。

### 数值

书写的差异导致数值解析的复杂


```R
# 我们使用较多的点分隔符
parse_double("1.23")
# 如果是以逗号分隔的整数位和小数位呢，用decimal_mark
parse_double("1,23", locale = locale(decimal_mark = ","))
```


1.23



1.23



```R
# 处理货币和百分比
parse_number("$100")

parse_number("20%")

parse_number("It cost $123.45")

parse_number("人民币￥100")
```


100



20



123.45



100



```R
# 位数多的话就以科学计数法表示了
parse_number("123 456 789")# 这样以空格分隔就会出问题
parse_number("123,456,789")# 以逗号分隔就没问题，以为默认是美式书写，其他书写需要设置locale

parse_number("123 456 789", locale = locale(grouping_mark = " "))
# 其他类似，用什么分隔就设置mark等于什么
parse_number("123.456.789.000.000.000", locale = locale(grouping_mark = "."))

```


123



123456789



123456789



1.23456789e+17


### 字符串

介绍字符串必然要涉及到计算机编码问题，现在用的多的是UTF-8编码，支持中英文及多种符号


```R
# 使用charToRaw()函数获得字符串的底层编码
charToRaw("a")
charToRaw("1")
charToRaw("A")
charToRaw("@")
charToRaw("李")
```


    [1] 61



    [1] 31



    [1] 41



    [1] 40



    [1] e6 9d 8e


readr全面支持UTF-8，我们使用时尽量都使用该编码，其他就不说了

### 因子

因子是R中用的非常普遍的分类变量，无论是在作图还是分析都离不开


```R
# 看例子吧
color <- c("white", "black", "red", "green", "blue")
parse_factor(c("white", "red", "green", "bluee"), levels = color)
parse_factor(c("white", "red", "green", "blue", "red"), levels = color)
# 不存在的因子会wainning
```

    Warning message:
    “1 parsing failure.
    row col           expected actual
      4  -- value in level set  bluee
    ”


<ol class=list-inline>
	<li>white</li>
	<li>red</li>
	<li>green</li>
	<li>&lt;NA&gt;</li>
</ol>

<details>
	<summary style=display:list-item;cursor:pointer>
		<strong>Levels</strong>:
	</summary>
	<ol class=list-inline>
		<li>'white'</li>
		<li>'black'</li>
		<li>'red'</li>
		<li>'green'</li>
		<li>'blue'</li>
	</ol>
</details>



<ol class=list-inline>
	<li>white</li>
	<li>red</li>
	<li>green</li>
	<li>blue</li>
	<li>red</li>
</ol>

<details>
	<summary style=display:list-item;cursor:pointer>
		<strong>Levels</strong>:
	</summary>
	<ol class=list-inline>
		<li>'white'</li>
		<li>'black'</li>
		<li>'red'</li>
		<li>'green'</li>
		<li>'blue'</li>
	</ol>
</details>


### 日期和时间


```R
# ISO 8601标准日期时间：年、月、日、时、分、秒
parse_datetime("2019-11-11-11-11-11")# 出错
parse_datetime("2011-11-11T111213")# UTC感兴趣的去查一查
parse_datetime("2019-10-26")
```

    Warning message:
    “1 parsing failure.
    row col   expected              actual
      1  -- date like  2019-11-11-11-11-11
    ”


    [1] NA



    [1] "2011-11-11 11:12:13 UTC"



    [1] "2019-10-26 UTC"



```R
# 同样的，parse_date()是日期，parse_time()是时间
parse_date("1970-01-01")
parse_date("1970/01/01")
parse_date("1970-1-1")# 站位的0不能省

parse_time("12:12")
parse_time("12:12 pm")
parse_time("20:20:20")
parse_time("18-30")# 冒号而不是连字符
```


<time datetime="1970-01-01">1970-01-01</time>



<time datetime="1970-01-01">1970-01-01</time>


    Warning message:
    “1 parsing failure.
    row col   expected   actual
      1  -- date like  1970-1-1
    ”


<time datetime="&lt;NA&gt;">&lt;NA&gt;</time>



    12:12:00



    12:12:00



    20:20:20


    Warning message:
    “1 parsing failure.
    row col   expected actual
      1  -- time like   18-30
    ”


    NA



```R
# R基础包中没有能够很好表示时间数据的内置类，可以使用hms包
# 可以提供自己的日期时间格式
# 百分号加代表日期和时间的字母，应该是通用的吧

parse_date("01/02/19", "%m/%d/%y")
parse_date("01/02/19", "%d/%m/%y")
parse_date("01/02/19", "%Y/%m/%d")# 日期中大小写不同
parse_date("2001/02/19", "%Y/%m/%d")

parse_time("20/21/22", "%H/%M/%S")# 时间是大写
```


<time datetime="2019-01-02">2019-01-02</time>



<time datetime="2019-02-01">2019-02-01</time>


    Warning message:
    “1 parsing failure.
    row col           expected   actual
      1  -- date like %Y/%m/%d 01/02/19
    ”


<time datetime="&lt;NA&gt;">&lt;NA&gt;</time>



<time datetime="2001-02-19">2001-02-19</time>



    20:21:22



```R
parse_number("123.456.789", locale = locale(decimal_mark = "."))

parse_number("123.456.789", locale = locale(grouping_mark = "."))

parse_number("123,456,789.123", locale = locale(grouping_mark = ",", 
                                            decimal_mark = "."))
# decimal_mark和group_mark一样会报错
# parse_number("123,456,789.123", locale = locale(grouping_mark = ",", 
#                                            decimal_mark = ","))
```


123.456



123456789



123456789.123



    Error: `decimal_mark` and `grouping_mark` must be different
    Traceback:


    1. parse_number("123,456,789.123", locale = locale(grouping_mark = ",", 
     .     decimal_mark = ","))

    2. parse_vector(x, col_number(), na = na, locale = locale, trim_ws = trim_ws)

    3. warn_problems(parse_vector_(x, collector, na = na, locale_ = locale, 
     .     trim_ws = trim_ws))

    4. n_problems(x)

    5. probs(x)

    6. suppressWarnings(x)

    7. withCallingHandlers(expr, warning = function(w) invokeRestart("muffleWarning"))

    8. parse_vector_(x, collector, na = na, locale_ = locale, trim_ws = trim_ws)

    9. locale(grouping_mark = ",", decimal_mark = ",")

    10. stop("`decimal_mark` and `grouping_mark` must be different", 
      .     call. = FALSE)



```R
# 解析以下日期和时间
d1 <- "January 1, 2010"
d2 <-　"2015-Mar-07" 
d3 <-　"06-Jun-2017" 
d4 <-　c("August 19 (2015)", "July 1 (2015)")
d5 <-　"12/30/14"# 2014年12月30日
t1 <-　"1705" 
t2 <-　"11:15:10.12 PM"
```


```R
parse_date(d1, "%B %d, %Y")
parse_date(d2, "%Y-%b-%d")
parse_date(d4, "%B %d (%Y)")
# 另外两个省了
parse_time(t1, "%H%M")
parse_time(t2, "%I:%M:%OS %p")
```


<time datetime="2010-01-01">2010-01-01</time>



<time datetime="2015-03-07">2015-03-07</time>



<ol class=list-inline>
	<li><time datetime="2015-08-19">2015-08-19</time></li>
	<li><time datetime="2015-07-01">2015-07-01</time></li>
</ol>




    17:05:00



    23:15:10.12


## 解析文件

readr使用启发式过程猜测每列的数据类型，先读取1000行，这些都可以改的，不过还是建议数据提前就整理好，如果数据不大的话在读取的时候就直接指定哪一部分需要更改默认设置，比如前1000行是整数，后面有浮点数，直接指定浮点数

这一部分需要就看书吧

## 写入文件

简要介绍write_csv()和write_rds()两个函数


```R
# 以纯文本保存文件用write_csv()和write_tsv()
challenge <-read_csv(readr_example("challenge.csv"), guess_max = 1001) 
write_csv(challenge, "data/challenge.csv")
write_rds(challenge, "data/challenge.rds")
# 各有优缺点，csv不保存类型信息，rds为R的二进制格式，在其他地方不好使
```

    Parsed with column specification:
    cols(
      x = [32mcol_double()[39m,
      y = [34mcol_date(format = "")[39m
    )


## 其他类型数据

haven可以读取SPSS、Stata、SAS文件

readxl可以读取Excel文件

其他可以参考《R语言实战》和其他资料

本章结束
