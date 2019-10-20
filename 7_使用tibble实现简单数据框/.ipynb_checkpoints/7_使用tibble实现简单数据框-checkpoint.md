
# 使用tibble实现简单数据框

这一部分作者也写的很简洁，无外乎建议我们使用tibble数据框来替代data.frame数据框，还有就是简单的创建和使用tibble数据框

由于jupyter对tibble数据框不支持，这里尽管会写，但是看不出来一些差异，所以还会在RDataScience_test目录里用Rmd写一份


```R
# 加载tidyverse包
library(tidyverse)
```

    ─ Attaching packages ──────────────────── tidyverse 1.2.1 ─
    ✔ ggplot2 3.1.0     ✔ purrr   0.2.5
    ✔ tibble  1.4.2     ✔ dplyr   0.7.8
    ✔ tidyr   0.8.2     ✔ stringr 1.3.1
    ✔ readr   1.1.1     ✔ forcats 0.3.0
    ─ Conflicts ───────────────────── tidyverse_conflicts() ─
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()


## 创建tibble


```R

### 从data.frame创建tibble
iris %>% head() # 看data.frame
as_tibble(iris) %>% head() # 看tibble，这里看不出来
```


<table>
<thead><tr><th scope=col>Sepal.Length</th><th scope=col>Sepal.Width</th><th scope=col>Petal.Length</th><th scope=col>Petal.Width</th><th scope=col>Species</th></tr></thead>
<tbody>
	<tr><td>5.1   </td><td>3.5   </td><td>1.4   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>4.9   </td><td>3.0   </td><td>1.4   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>4.7   </td><td>3.2   </td><td>1.3   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>4.6   </td><td>3.1   </td><td>1.5   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>5.0   </td><td>3.6   </td><td>1.4   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>5.4   </td><td>3.9   </td><td>1.7   </td><td>0.4   </td><td>setosa</td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>Sepal.Length</th><th scope=col>Sepal.Width</th><th scope=col>Petal.Length</th><th scope=col>Petal.Width</th><th scope=col>Species</th></tr></thead>
<tbody>
	<tr><td>5.1   </td><td>3.5   </td><td>1.4   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>4.9   </td><td>3.0   </td><td>1.4   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>4.7   </td><td>3.2   </td><td>1.3   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>4.6   </td><td>3.1   </td><td>1.5   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>5.0   </td><td>3.6   </td><td>1.4   </td><td>0.2   </td><td>setosa</td></tr>
	<tr><td>5.4   </td><td>3.9   </td><td>1.7   </td><td>0.4   </td><td>setosa</td></tr>
</tbody>
</table>




```R
##  通过tibble()函数使用vector创建tibble
tibble(
    x = 1:10,
    y = 1,
    z= x^2 + y)
```


<table>
<thead><tr><th scope=col>x</th><th scope=col>y</th><th scope=col>z</th></tr></thead>
<tbody>
	<tr><td> 1 </td><td>1  </td><td>  2</td></tr>
	<tr><td> 2 </td><td>1  </td><td>  5</td></tr>
	<tr><td> 3 </td><td>1  </td><td> 10</td></tr>
	<tr><td> 4 </td><td>1  </td><td> 17</td></tr>
	<tr><td> 5 </td><td>1  </td><td> 26</td></tr>
	<tr><td> 6 </td><td>1  </td><td> 37</td></tr>
	<tr><td> 7 </td><td>1  </td><td> 50</td></tr>
	<tr><td> 8 </td><td>1  </td><td> 65</td></tr>
	<tr><td> 9 </td><td>1  </td><td> 82</td></tr>
	<tr><td>10 </td><td>1  </td><td>101</td></tr>
</tbody>
</table>



tibble尽管是新的，但相比data.frame功能要少，不过接受R中无效的变量名称，用反引号引起来即可,使用这些变量的时候也要使用反引号


```R
tb <- tibble(
    `)` = "smile",
    ` ` = "space",
    `2000` = "number")
tb
```


<table>
<thead><tr><th scope=col>)</th><th scope=col> </th><th scope=col>2000</th></tr></thead>
<tbody>
	<tr><td>smile </td><td>space </td><td>number</td></tr>
</tbody>
</table>




```R
# 也可以使用tribble()函数创建tibble，列标题由公式(~开头)定义，数据条目以逗号分隔
tribble(
    ~x,~y,~z,
    #--|--|--# 是注释
    "a", 2, 3.6,
    "b", 1, 8.4
)
```


<table>
<thead><tr><th scope=col>x</th><th scope=col>y</th><th scope=col>z</th></tr></thead>
<tbody>
	<tr><td>a  </td><td>2  </td><td>3.6</td></tr>
	<tr><td>b  </td><td>1  </td><td>8.4</td></tr>
</tbody>
</table>



## 对比 tibble与data.frame

### 打印的差异

tibble默认只显示前10行，而且列是适合屏幕的，还打印数据类型，jupyter不支持，看不出来；data.frame的打印就省略了


```R
tibble(
    a = lubridate::now() + runif(1e3)*86400,
    b = lubridate::today() + runif(1e3)*30,
    c = 1:1e3,
    d = runif(1e3),
    e = sample(letters, 1e3, replace = T)
)%>% head()
```

    Warning message:
    “运行命令'timedatectl'的状态是1”


<table>
<thead><tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th><th scope=col>d</th><th scope=col>e</th></tr></thead>
<tbody>
	<tr><td>2019-10-20 22:49:36</td><td>2019-11-05         </td><td>1                  </td><td>0.4295705          </td><td>e                  </td></tr>
	<tr><td>2019-10-21 10:00:32</td><td>2019-10-21         </td><td>2                  </td><td>0.8071014          </td><td>d                  </td></tr>
	<tr><td>2019-10-21 07:53:54</td><td>2019-11-16         </td><td>3                  </td><td>0.2065430          </td><td>r                  </td></tr>
	<tr><td>2019-10-21 19:40:49</td><td>2019-11-03         </td><td>4                  </td><td>0.2152468          </td><td>f                  </td></tr>
	<tr><td>2019-10-21 06:50:58</td><td>2019-11-13         </td><td>5                  </td><td>0.9688459          </td><td>m                  </td></tr>
	<tr><td>2019-10-21 10:59:19</td><td>2019-10-31         </td><td>6                  </td><td>0.1238433          </td><td>f                  </td></tr>
</tbody>
</table>




```R
# 更改默认显示输出
# 使用print()函数，n：行数，width：显示宽度
nycflights13::flights %>%
print(n = 10, width = Inf)
```

    # A tibble: 336,776 x 19
        year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
       <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
     1  2013     1     1      517            515         2      830            819
     2  2013     1     1      533            529         4      850            830
     3  2013     1     1      542            540         2      923            850
     4  2013     1     1      544            545        -1     1004           1022
     5  2013     1     1      554            600        -6      812            837
     6  2013     1     1      554            558        -4      740            728
     7  2013     1     1      555            600        -5      913            854
     8  2013     1     1      557            600        -3      709            723
     9  2013     1     1      557            600        -3      838            846
    10  2013     1     1      558            600        -2      753            745
       arr_delay carrier flight tailnum origin dest  air_time distance  hour minute
           <dbl> <chr>    <int> <chr>   <chr>  <chr>    <dbl>    <dbl> <dbl>  <dbl>
     1        11 UA        1545 N14228  EWR    IAH        227     1400     5     15
     2        20 UA        1714 N24211  LGA    IAH        227     1416     5     29
     3        33 AA        1141 N619AA  JFK    MIA        160     1089     5     40
     4       -18 B6         725 N804JB  JFK    BQN        183     1576     5     45
     5       -25 DL         461 N668DN  LGA    ATL        116      762     6      0
     6        12 UA        1696 N39463  EWR    ORD        150      719     5     58
     7        19 B6         507 N516JB  EWR    FLL        158     1065     6      0
     8       -14 EV        5708 N829AS  LGA    IAD         53      229     6      0
     9        -8 B6          79 N593JB  JFK    MCO        140      944     6      0
    10         8 AA         301 N3ALAA  LGA    ORD        138      733     6      0
       time_hour          
       <dttm>             
     1 2013-01-01 05:00:00
     2 2013-01-01 05:00:00
     3 2013-01-01 05:00:00
     4 2013-01-01 05:00:00
     5 2013-01-01 06:00:00
     6 2013-01-01 05:00:00
     7 2013-01-01 06:00:00
     8 2013-01-01 06:00:00
     9 2013-01-01 06:00:00
    10 2013-01-01 06:00:00
    # ... with 3.368e+05 more rows


还可以通过设置以下选项来控制默认的打印方式。

• options(tibble.print_max = n, tibble.pring_min = m)：如果多于m行，则只打印出n行。options(tibble.print_min = Inf)表示总是打印所有行。

• options(tibble.width = Inf)表示总是打印所有列，不考虑屏幕的宽度。

### 取子集

取子集的方法无非是用"$"和[[]]



```R
df <- tibble(
    x = runif(5),
    y = rnorm(5)
)

df$x
df[["x"]]
df[,"x"]
df[,1]
```


<ol class=list-inline>
	<li>0.707784972852096</li>
	<li>0.13322418788448</li>
	<li>0.764080885564908</li>
	<li>0.721324865939096</li>
	<li>0.555748503422365</li>
</ol>




<ol class=list-inline>
	<li>0.707784972852096</li>
	<li>0.13322418788448</li>
	<li>0.764080885564908</li>
	<li>0.721324865939096</li>
	<li>0.555748503422365</li>
</ol>




<table>
<thead><tr><th scope=col>x</th></tr></thead>
<tbody>
	<tr><td>0.7077850</td></tr>
	<tr><td>0.1332242</td></tr>
	<tr><td>0.7640809</td></tr>
	<tr><td>0.7213249</td></tr>
	<tr><td>0.5557485</td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>x</th></tr></thead>
<tbody>
	<tr><td>0.7077850</td></tr>
	<tr><td>0.1332242</td></tr>
	<tr><td>0.7640809</td></tr>
	<tr><td>0.7213249</td></tr>
	<tr><td>0.5557485</td></tr>
</tbody>
</table>




```R
# 要想在管道中使用这些提取操作，使用特殊占位符"."
df %>% .$x
df %>% .[["x"]]
```


<ol class=list-inline>
	<li>0.707784972852096</li>
	<li>0.13322418788448</li>
	<li>0.764080885564908</li>
	<li>0.721324865939096</li>
	<li>0.555748503422365</li>
</ol>




<ol class=list-inline>
	<li>0.707784972852096</li>
	<li>0.13322418788448</li>
	<li>0.764080885564908</li>
	<li>0.721324865939096</li>
	<li>0.555748503422365</li>
</ol>



与data.frame相比，tibble更严格：它不能进行部分匹配，如果想要访问的列不存在，它会生成一条警告信息。

### 与旧代码进行交互

有些函数不支持tibble，可以使用as.data.frame()函数转换

## 练习

# (1) 如何识别一个对象是否为tibble？


# 直接打印出来即可，显示上很容易区别



```R
# (2) 对比在data.frame和等价的tibble上进行的以下操作。有何区别？
# 为什么默认的数据框操作会让人感到沮丧

# df <-data.frame(abc =1, xyz ="a") 
# df$x 
# df[, "xyz"] 
# df[, c("abc", "xyz")]
```


```R
df <-data.frame(abc =1, xyz ="a") 
df$x 
df[, "xyz"] 
df[, c("abc", "xyz")]
```


a
<details>
	<summary style=display:list-item;cursor:pointer>
		<strong>Levels</strong>:
	</summary>
	'a'
</details>



a
<details>
	<summary style=display:list-item;cursor:pointer>
		<strong>Levels</strong>:
	</summary>
	'a'
</details>



<table>
<thead><tr><th scope=col>abc</th><th scope=col>xyz</th></tr></thead>
<tbody>
	<tr><td>1</td><td>a</td></tr>
</tbody>
</table>




```R
df <-tibble(abc =1, xyz ="a") 
df$x # tibble更加严格，不能模糊匹配
df[, "xyz"] 
df[, c("abc", "xyz")]
```

    Warning message:
    “Unknown or uninitialised column: 'x'.”


    NULL



<table>
<thead><tr><th scope=col>xyz</th></tr></thead>
<tbody>
	<tr><td>a</td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>abc</th><th scope=col>xyz</th></tr></thead>
<tbody>
	<tr><td>1</td><td>a</td></tr>
</tbody>
</table>




```R
## (3) 如果将一个变量的名称保存在一个对象中，
# 如var  <-  "mpg"，如何从tibble中提取出这个变量？

# 用上面的例子
var <- "xyz"
# df%var # 这样不可以
df[,var]
df[[var]]
# df$`var` # 这样也不可以
```


<table>
<thead><tr><th scope=col>xyz</th></tr></thead>
<tbody>
	<tr><td>a</td></tr>
</tbody>
</table>




'a'



```R
## (4) 在以下的数据框中练习如何引用不符合语法规则的变量名。
## a. 提取名称为1的变量。
## b. 绘制表示变量1和变量2关系的散点图。
## c. 创建一个名称为3的新列，其值为列2除以列1。
## d. 将这些列重新命名为one、two和three。
annoying <-tibble(   
    `1` =1:10,   
    `2` = `1` *2+rnorm(length(`1`)) 
)
```


```R
# a
annoying$`1`
# b
ggplot(annoying) + geom_point(aes(x = `1`, y = `2`))
# c
(annoying <- mutate(annoying, `3` = `2`/`1`))
# d
colnames(annoying) = c("one","two","three")
annoying
```


<ol class=list-inline>
	<li>1</li>
	<li>2</li>
	<li>3</li>
	<li>4</li>
	<li>5</li>
	<li>6</li>
	<li>7</li>
	<li>8</li>
	<li>9</li>
	<li>10</li>
</ol>






<table>
<thead><tr><th scope=col>1</th><th scope=col>2</th><th scope=col>3</th></tr></thead>
<tbody>
	<tr><td> 1       </td><td> 3.080166</td><td>3.080166 </td></tr>
	<tr><td> 2       </td><td> 3.504817</td><td>1.752409 </td></tr>
	<tr><td> 3       </td><td> 5.907348</td><td>1.969116 </td></tr>
	<tr><td> 4       </td><td> 8.873859</td><td>2.218465 </td></tr>
	<tr><td> 5       </td><td>12.221696</td><td>2.444339 </td></tr>
	<tr><td> 6       </td><td>11.526668</td><td>1.921111 </td></tr>
	<tr><td> 7       </td><td>13.608353</td><td>1.944050 </td></tr>
	<tr><td> 8       </td><td>17.573763</td><td>2.196720 </td></tr>
	<tr><td> 9       </td><td>18.110902</td><td>2.012322 </td></tr>
	<tr><td>10       </td><td>18.988575</td><td>1.898857 </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>one</th><th scope=col>two</th><th scope=col>three</th></tr></thead>
<tbody>
	<tr><td> 1       </td><td> 3.080166</td><td>3.080166 </td></tr>
	<tr><td> 2       </td><td> 3.504817</td><td>1.752409 </td></tr>
	<tr><td> 3       </td><td> 5.907348</td><td>1.969116 </td></tr>
	<tr><td> 4       </td><td> 8.873859</td><td>2.218465 </td></tr>
	<tr><td> 5       </td><td>12.221696</td><td>2.444339 </td></tr>
	<tr><td> 6       </td><td>11.526668</td><td>1.921111 </td></tr>
	<tr><td> 7       </td><td>13.608353</td><td>1.944050 </td></tr>
	<tr><td> 8       </td><td>17.573763</td><td>2.196720 </td></tr>
	<tr><td> 9       </td><td>18.110902</td><td>2.012322 </td></tr>
	<tr><td>10       </td><td>18.988575</td><td>1.898857 </td></tr>
</tbody>
</table>




![png](output_25_4.png)


结束


```R

```
