# 16_使用purrr实现迭代

purrr包在迭代方面确实很好用，有些地方也不是很好理解，有多好用我们看例子


```R
library(tidyverse)
```

    ─ [1mAttaching packages[22m ──────────────────── tidyverse 1.2.1 ─
    [32m✔[39m [34mggplot2[39m 3.2.0     [32m✔[39m [34mpurrr  [39m 0.3.2
    [32m✔[39m [34mtibble [39m 2.1.3     [32m✔[39m [34mdplyr  [39m 0.8.3
    [32m✔[39m [34mtidyr  [39m 0.8.3     [32m✔[39m [34mstringr[39m 1.4.0
    [32m✔[39m [34mreadr  [39m 1.3.1     [32m✔[39m [34mforcats[39m 0.4.0
    ─ [1mConflicts[22m ───────────────────── tidyverse_conflicts() ─
    [31m✖[39m [34mdplyr[39m::[32mfilter()[39m masks [34mstats[39m::filter()
    [31m✖[39m [34mdplyr[39m::[32mlag()[39m    masks [34mstats[39m::lag()


## for 循环


```R
# 这里是一个简单的数据框
df <- tibble(
    a = rnorm(10),
    b = rnorm(10),
    c = rnorm(10),
    d = rnorm(10)
)

# 例如我们要计算中位数
median(df$a)
median(df$b)
median(df$c)
median(df$d)
# 复制粘贴也可以接受

# for循环解决方法

output <- vector("double", ncol(df))
for (i in seq_along(df)) {
    output[[i]] <- median(df[[i]])
}
# vector()函数创建给定长度的空向量
# seq_along()函数生成一定长度的序列
# 双方括号要比单方括号好，在同样的情况下
output
```


0.633988221779616



0.314986892686608



0.34051040038387



-0.238654126371758



<ol class=list-inline>
	<li>0.633988221779616</li>
	<li>0.314986892686608</li>
	<li>0.34051040038387</li>
	<li>-0.238654126371758</li>
</ol>



## 练习


```R
# a. 计算出mtcars数据集中每列的均值。
head(mtcars)
mean(mtcars$mpg)
# ;
# ;
# ;手动也可以，很麻烦
mean(mtcars$carb)

# for循环实现
out_mean <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)){
    out_mean[[i]] <- mean(mtcars[[i]])
}

out_mean
```


<table>
<caption>A data.frame: 6 × 11</caption>
<thead>
	<tr><th></th><th scope=col>mpg</th><th scope=col>cyl</th><th scope=col>disp</th><th scope=col>hp</th><th scope=col>drat</th><th scope=col>wt</th><th scope=col>qsec</th><th scope=col>vs</th><th scope=col>am</th><th scope=col>gear</th><th scope=col>carb</th></tr>
	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>Mazda RX4</th><td>21.0</td><td>6</td><td>160</td><td>110</td><td>3.90</td><td>2.620</td><td>16.46</td><td>0</td><td>1</td><td>4</td><td>4</td></tr>
	<tr><th scope=row>Mazda RX4 Wag</th><td>21.0</td><td>6</td><td>160</td><td>110</td><td>3.90</td><td>2.875</td><td>17.02</td><td>0</td><td>1</td><td>4</td><td>4</td></tr>
	<tr><th scope=row>Datsun 710</th><td>22.8</td><td>4</td><td>108</td><td> 93</td><td>3.85</td><td>2.320</td><td>18.61</td><td>1</td><td>1</td><td>4</td><td>1</td></tr>
	<tr><th scope=row>Hornet 4 Drive</th><td>21.4</td><td>6</td><td>258</td><td>110</td><td>3.08</td><td>3.215</td><td>19.44</td><td>1</td><td>0</td><td>3</td><td>1</td></tr>
	<tr><th scope=row>Hornet Sportabout</th><td>18.7</td><td>8</td><td>360</td><td>175</td><td>3.15</td><td>3.440</td><td>17.02</td><td>0</td><td>0</td><td>3</td><td>2</td></tr>
	<tr><th scope=row>Valiant</th><td>18.1</td><td>6</td><td>225</td><td>105</td><td>2.76</td><td>3.460</td><td>20.22</td><td>1</td><td>0</td><td>3</td><td>1</td></tr>
</tbody>
</table>




20.090625



2.8125



<ol class=list-inline>
	<li>20.090625</li>
	<li>6.1875</li>
	<li>230.721875</li>
	<li>146.6875</li>
	<li>3.5965625</li>
	<li>3.21725</li>
	<li>17.84875</li>
	<li>0.4375</li>
	<li>0.40625</li>
	<li>3.6875</li>
	<li>2.8125</li>
</ol>




```R
# b. 确定nycflights13::flights数据集中每列的类型。
library(nycflights13)
head(flights)
typeof(flights$year)# 查看数据类型

# 循环体已经知道，准备循环
out_type <- vector("character", ncol(flights))
# 使用charactor是因为typeof输出是字符型
for (i in seq_along(flights)){
    out_type[[i]] <- typeof(flights[[i]])
}

out_type %>% t()
```


<table>
<caption>A tibble: 6 × 19</caption>
<thead>
	<tr><th scope=col>year</th><th scope=col>month</th><th scope=col>day</th><th scope=col>dep_time</th><th scope=col>sched_dep_time</th><th scope=col>dep_delay</th><th scope=col>arr_time</th><th scope=col>sched_arr_time</th><th scope=col>arr_delay</th><th scope=col>carrier</th><th scope=col>flight</th><th scope=col>tailnum</th><th scope=col>origin</th><th scope=col>dest</th><th scope=col>air_time</th><th scope=col>distance</th><th scope=col>hour</th><th scope=col>minute</th><th scope=col>time_hour</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dttm&gt;</th></tr>
</thead>
<tbody>
	<tr><td>2013</td><td>1</td><td>1</td><td>517</td><td>515</td><td> 2</td><td> 830</td><td> 819</td><td> 11</td><td>UA</td><td>1545</td><td>N14228</td><td>EWR</td><td>IAH</td><td>227</td><td>1400</td><td>5</td><td>15</td><td>2013-01-01 05:00:00</td></tr>
	<tr><td>2013</td><td>1</td><td>1</td><td>533</td><td>529</td><td> 4</td><td> 850</td><td> 830</td><td> 20</td><td>UA</td><td>1714</td><td>N24211</td><td>LGA</td><td>IAH</td><td>227</td><td>1416</td><td>5</td><td>29</td><td>2013-01-01 05:00:00</td></tr>
	<tr><td>2013</td><td>1</td><td>1</td><td>542</td><td>540</td><td> 2</td><td> 923</td><td> 850</td><td> 33</td><td>AA</td><td>1141</td><td>N619AA</td><td>JFK</td><td>MIA</td><td>160</td><td>1089</td><td>5</td><td>40</td><td>2013-01-01 05:00:00</td></tr>
	<tr><td>2013</td><td>1</td><td>1</td><td>544</td><td>545</td><td>-1</td><td>1004</td><td>1022</td><td>-18</td><td>B6</td><td> 725</td><td>N804JB</td><td>JFK</td><td>BQN</td><td>183</td><td>1576</td><td>5</td><td>45</td><td>2013-01-01 05:00:00</td></tr>
	<tr><td>2013</td><td>1</td><td>1</td><td>554</td><td>600</td><td>-6</td><td> 812</td><td> 837</td><td>-25</td><td>DL</td><td> 461</td><td>N668DN</td><td>LGA</td><td>ATL</td><td>116</td><td> 762</td><td>6</td><td> 0</td><td>2013-01-01 06:00:00</td></tr>
	<tr><td>2013</td><td>1</td><td>1</td><td>554</td><td>558</td><td>-4</td><td> 740</td><td> 728</td><td> 12</td><td>UA</td><td>1696</td><td>N39463</td><td>EWR</td><td>ORD</td><td>150</td><td> 719</td><td>5</td><td>58</td><td>2013-01-01 05:00:00</td></tr>
</tbody>
</table>




'integer'



<table>
<caption>A matrix: 1 × 19 of type chr</caption>
<tbody>
	<tr><td>integer</td><td>integer</td><td>integer</td><td>integer</td><td>integer</td><td>double</td><td>integer</td><td>integer</td><td>double</td><td>character</td><td>integer</td><td>character</td><td>character</td><td>character</td><td>double</td><td>double</td><td>double</td><td>double</td><td>double</td></tr>
</tbody>
</table>




```R
# c. 计算出iris数据集中每列唯一值的数量
head(iris)# 查看数据
unique(iris$Species)%>%length()# unique()函数去重
table(iris$Species)
# 以上是重复体
out_num <- vector("integer", ncol(iris))
for (i in seq_along(iris)){
    out_num[[i]] <- length(unique(iris[[i]]))
}
out_num

# 下面对向量进行了命名，更清晰
iris_uniq <- vector("double", ncol(iris))
names(iris_uniq) <- names(iris)
for (i in names(iris)) {
  iris_uniq[i] <- length(unique(iris[[i]]))
}
iris_uniq
```


<table>
<caption>A data.frame: 6 × 5</caption>
<thead>
	<tr><th scope=col>Sepal.Length</th><th scope=col>Sepal.Width</th><th scope=col>Petal.Length</th><th scope=col>Petal.Width</th><th scope=col>Species</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>
</thead>
<tbody>
	<tr><td>5.1</td><td>3.5</td><td>1.4</td><td>0.2</td><td>setosa</td></tr>
	<tr><td>4.9</td><td>3.0</td><td>1.4</td><td>0.2</td><td>setosa</td></tr>
	<tr><td>4.7</td><td>3.2</td><td>1.3</td><td>0.2</td><td>setosa</td></tr>
	<tr><td>4.6</td><td>3.1</td><td>1.5</td><td>0.2</td><td>setosa</td></tr>
	<tr><td>5.0</td><td>3.6</td><td>1.4</td><td>0.2</td><td>setosa</td></tr>
	<tr><td>5.4</td><td>3.9</td><td>1.7</td><td>0.4</td><td>setosa</td></tr>
</tbody>
</table>




3



    
        setosa versicolor  virginica 
            50         50         50 



<ol class=list-inline>
	<li>35</li>
	<li>23</li>
	<li>43</li>
	<li>22</li>
	<li>3</li>
</ol>




<dl class=dl-horizontal>
	<dt>Sepal.Length</dt>
		<dd>35</dd>
	<dt>Sepal.Width</dt>
		<dd>23</dd>
	<dt>Petal.Length</dt>
		<dd>43</dd>
	<dt>Petal.Width</dt>
		<dd>22</dd>
	<dt>Species</dt>
		<dd>3</dd>
</dl>




```R
# d. 分别使用μ= -10、0、10和100的正态分布生成10个随机数

# 直接写了
mu <- c(-10, 0, 10, 100)
output <- vector("list",length(mu))
for (i in seq_along(mu)){
    output[[i]] <- rnorm(10, mean = mu[[i]])
}
output
```


<ol>
	<li><ol class=list-inline>
	<li>-10.9895859639989</li>
	<li>-11.5418366205284</li>
	<li>-10.8450489029227</li>
	<li>-10.4538940953841</li>
	<li>-10.3387502219951</li>
	<li>-9.20382486699511</li>
	<li>-10.7660795027087</li>
	<li>-9.68420491141331</li>
	<li>-8.89805951176629</li>
	<li>-10.0416990086735</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>-1.84301435860798</li>
	<li>0.613515804896667</li>
	<li>0.621807803439537</li>
	<li>-0.109308407880036</li>
	<li>0.348353048884382</li>
	<li>-0.213754600910744</li>
	<li>0.661554400833045</li>
	<li>-0.922527504942822</li>
	<li>0.546669678477325</li>
	<li>0.368312003918553</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>11.9669066241575</li>
	<li>8.77756221395076</li>
	<li>10.0793343695548</li>
	<li>8.47357137472204</li>
	<li>10.3406260021458</li>
	<li>10.4674303500044</li>
	<li>10.9898713550137</li>
	<li>9.48405290039471</li>
	<li>10.6754392059497</li>
	<li>9.75957372146529</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>101.27511916689</li>
	<li>99.6719784689655</li>
	<li>97.8808546507369</li>
	<li>99.9866567683821</li>
	<li>102.010459041466</li>
	<li>100.347404107866</li>
	<li>99.5666314178817</li>
	<li>100.227230664617</li>
	<li>100.937901473172</li>
	<li>100.600551478769</li>
</ol>
</li>
</ol>




```R
# 使用支持向量运算的现有函数替换for循环
out <- ""
for (x in letters) {   
    out <- stringr::str_c(out, x) 
} 
out

str_c(letters, collapse = "")
```


'abcdefghijklmnopqrstuvwxyz'



'abcdefghijklmnopqrstuvwxyz'



```R
# 使用支持向量运算的现有函数替换以下示例中的for循环
x <-sample(100) 
sd <- 0
for (i in seq_along(x)) {  
    sd <- sd + (x[i] -mean(x)) ^ 2
} 
    sd <-sqrt(sd / (length(x) -1)) 
# 能看出来是计算样本标准差
sd
sd(x)# 现成函数很方便
```


29.011491975882



29.011491975882



```R
# 使用支持向量运算的现有函数替换以下示例中的for循环
x <-runif(100) 
# x <- 1:10
out <-vector("numeric", length(x)) 
out[1] <- x[1] 
for (i in 2:length(x)) {  
    out[i] <- out[i -1] + x[i] 
}
out %>% matrix(nrow = 10)
accumulate(x, `+`) %>% matrix(nrow = 10)# 一个累计函数就解决了
```


<table>
<caption>A matrix: 10 × 10 of type dbl</caption>
<tbody>
	<tr><td>0.6973035</td><td>3.938048</td><td> 8.259073</td><td>13.67238</td><td>17.15333</td><td>22.35866</td><td>29.25973</td><td>34.10490</td><td>40.80170</td><td>46.68028</td></tr>
	<tr><td>1.3506894</td><td>4.384395</td><td> 8.756041</td><td>14.10328</td><td>17.47762</td><td>22.91591</td><td>29.86711</td><td>34.71337</td><td>40.94017</td><td>47.60513</td></tr>
	<tr><td>1.6900253</td><td>4.754075</td><td> 8.877519</td><td>14.13409</td><td>17.79589</td><td>23.72497</td><td>30.28393</td><td>35.39988</td><td>41.76018</td><td>48.51303</td></tr>
	<tr><td>1.7954746</td><td>4.872559</td><td> 9.830943</td><td>14.14016</td><td>18.60000</td><td>24.13645</td><td>31.04306</td><td>36.22826</td><td>42.63365</td><td>49.08509</td></tr>
	<tr><td>2.4524392</td><td>5.033890</td><td> 9.974643</td><td>14.19695</td><td>19.22917</td><td>25.01270</td><td>31.19702</td><td>36.69341</td><td>43.16276</td><td>49.49770</td></tr>
	<tr><td>2.5742237</td><td>5.298167</td><td>10.853133</td><td>14.35575</td><td>19.87172</td><td>25.81202</td><td>31.26369</td><td>37.65621</td><td>44.04778</td><td>50.01020</td></tr>
	<tr><td>3.2427838</td><td>5.578703</td><td>11.613923</td><td>14.59185</td><td>20.28119</td><td>26.70988</td><td>31.87535</td><td>38.52491</td><td>44.78916</td><td>50.45304</td></tr>
	<tr><td>3.3848914</td><td>6.527052</td><td>11.957272</td><td>15.44704</td><td>20.53768</td><td>27.64155</td><td>32.12513</td><td>39.51977</td><td>45.62506</td><td>50.87641</td></tr>
	<tr><td>3.6706284</td><td>7.204942</td><td>12.898611</td><td>15.97371</td><td>21.21989</td><td>28.44343</td><td>32.55670</td><td>40.39189</td><td>45.97259</td><td>51.13508</td></tr>
	<tr><td>3.6844165</td><td>8.110477</td><td>13.113221</td><td>16.96792</td><td>21.52370</td><td>28.78806</td><td>33.34381</td><td>40.56337</td><td>46.23726</td><td>51.56451</td></tr>
</tbody>
</table>




<table>
<caption>A matrix: 10 × 10 of type dbl</caption>
<tbody>
	<tr><td>0.6973035</td><td>3.938048</td><td> 8.259073</td><td>13.67238</td><td>17.15333</td><td>22.35866</td><td>29.25973</td><td>34.10490</td><td>40.80170</td><td>46.68028</td></tr>
	<tr><td>1.3506894</td><td>4.384395</td><td> 8.756041</td><td>14.10328</td><td>17.47762</td><td>22.91591</td><td>29.86711</td><td>34.71337</td><td>40.94017</td><td>47.60513</td></tr>
	<tr><td>1.6900253</td><td>4.754075</td><td> 8.877519</td><td>14.13409</td><td>17.79589</td><td>23.72497</td><td>30.28393</td><td>35.39988</td><td>41.76018</td><td>48.51303</td></tr>
	<tr><td>1.7954746</td><td>4.872559</td><td> 9.830943</td><td>14.14016</td><td>18.60000</td><td>24.13645</td><td>31.04306</td><td>36.22826</td><td>42.63365</td><td>49.08509</td></tr>
	<tr><td>2.4524392</td><td>5.033890</td><td> 9.974643</td><td>14.19695</td><td>19.22917</td><td>25.01270</td><td>31.19702</td><td>36.69341</td><td>43.16276</td><td>49.49770</td></tr>
	<tr><td>2.5742237</td><td>5.298167</td><td>10.853133</td><td>14.35575</td><td>19.87172</td><td>25.81202</td><td>31.26369</td><td>37.65621</td><td>44.04778</td><td>50.01020</td></tr>
	<tr><td>3.2427838</td><td>5.578703</td><td>11.613923</td><td>14.59185</td><td>20.28119</td><td>26.70988</td><td>31.87535</td><td>38.52491</td><td>44.78916</td><td>50.45304</td></tr>
	<tr><td>3.3848914</td><td>6.527052</td><td>11.957272</td><td>15.44704</td><td>20.53768</td><td>27.64155</td><td>32.12513</td><td>39.51977</td><td>45.62506</td><td>50.87641</td></tr>
	<tr><td>3.6706284</td><td>7.204942</td><td>12.898611</td><td>15.97371</td><td>21.21989</td><td>28.44343</td><td>32.55670</td><td>40.39189</td><td>45.97259</td><td>51.13508</td></tr>
	<tr><td>3.6844165</td><td>8.110477</td><td>13.113221</td><td>16.96792</td><td>21.52370</td><td>28.78806</td><td>33.34381</td><td>40.56337</td><td>46.23726</td><td>51.56451</td></tr>
</tbody>
</table>



## for循环变体


```R
#修改现有对象

# 还是前面的例子
df <- tibble(
    a = rnorm(10),
    b = rnorm(10),
    c = rnorm(10),
    d = rnorm(10)
)

rescale01 <- function(x) {
    rng <- range(x, na.rm = T)
    (x - rng[1]) / (rng[2] - rng[1])
}

df$a <-rescale01(df$a) 
df$b <-rescale01(df$b) 
df$c <-rescale01(df$c) 
df$d <-rescale01(df$d)

# for循环实现如下
for (i in seq_along(df)) {
    df[[i]] <- rescale01(df[[i]])
}

# 要记住使用[[，而不是[。你或许已经发现了，
# 我们在所有for循环中使用的都是[[。
# 我们认为甚至在原子向量中最好也使用[[，
# 因为它可以明确表示我们要处理的是单个元素

# 循环模式

# 除了前面的数值索引，
# 还可以通过元素进行循环以及按名称进行循环，
# 前面已经用过了

# 如果想要创建命名的输出向量，请一定按照如下方式进行命名：

# results <-vector("list", length(x)) 

# names(results) <-names(x)

result <- vector("double", length(df))
names(result) <- names(df)

# for (i in seq_along(df)){
#     name <- names(df)[[i]]
#     value <- df[[i]]
# }
# name
# value
# 这里不合适，试一下就明白了

mean(df$a)
mean(df$b)
mean(df$c)
mean(df$d)

for (i in names(result)){
    print(i)
    result[i] <- mean(df[[i]])# 再次强调用双方括号
}

result
```


0.386486837831051



0.660216206921165



0.478502584665723



0.470834987465262


    [1] "a"
    [1] "b"
    [1] "c"
    [1] "d"



<dl class=dl-horizontal>
	<dt>a</dt>
		<dd>0.386486837831051</dd>
	<dt>b</dt>
		<dd>0.660216206921165</dd>
	<dt>c</dt>
		<dd>0.478502584665723</dd>
	<dt>d</dt>
		<dd>0.470834987465262</dd>
</dl>




```R
## 未知的输出长度
# sample(100,1)
# rnorm(sample(100,1), 0)
# mean(rnorm(sample(100,1), 0))

# 例如
means <- c(0, 1, 2)
output <- double()
for (i in seq_along(means)) {
    n <- sample(100, 1)
    output <- c(output, rnorm(n, means[[i]]))
}
str(output)

# 这种方式很低效，如果元素数量多，将会非常耗时

# 将结果保存到列表中的解决方法
out <- vector("list", length(means))
for (i in seq_along(means)) {
    n <- sample(100, 1)
    out[[i]] <- rnorm(n, means[[i]])
}
str(out)
str(unlist(out))# 列表转向量
str(flatten_dbl(out))# 来自purrr包的列表转向量函数

# 只要遇到类似情况，就应该使用一个更复杂的对象来保存每次迭代的结果，
# 最后再一次性组合起来。

# 未知的序列长度
# 此时用while循环

# while (condition) {   
#     # 循环体
# }

# 使用while循环找出了连续3次掷出正面向上的硬币所需的投掷次数

flip <- function() sample(c("T", "H"), 1)

flips <- 0
nheads <- 0

while(nheads < 3) {
    if (flip() == "H") {
        nheads <- nheads + 1
    } else {
        nheads <- 0
    }
    flips <- flips + 1
}

flips

# while循环用的少，当不知道迭代次数的时候用
```

     num [1:110] -1.446 -0.865 0.409 -0.86 -1.618 ...
    List of 3
     $ : num [1:82] -1.485 1.063 -1.168 0.356 -1.372 ...
     $ : num [1:72] 0.917 2.902 1.368 1.292 0.176 ...
     $ : num [1:95] 3.75 2.41 1.47 2.52 1.45 ...
     num [1:249] -1.485 1.063 -1.168 0.356 -1.372 ...
     num [1:249] -1.485 1.063 -1.168 0.356 -1.372 ...



5


## 练习

(1) 假设一个目录中全是你想要读入的CSV文件。你已经将这些文件的路径保存在向量files <- dir("data/", pattern = "\\.csv$", full.names = TRUE)中，现在想要使用read_csv()函数来读取每个文件。编写一个for循环将这些文件加载到一个数据框中。


```R
files <- dir("abc_data/", pattern = "\\.csv$", full.names = TRUE)
out <-vector("list", length(files))

for (i in files) {
    print(i)
    nm <- str_split(i, "/", simplify = T)[1,3]
    out[[nm]] <- read_csv(file = i, col_names = T, quote = "")

}# 利用一下字符串拆分名一下名
out
bind_rows(out)
bind_cols(out)
```

    [1] "abc_data//abc.csv"


    Parsed with column specification:
    cols(
      a = [32mcol_double()[39m,
      b = [32mcol_double()[39m,
      c = [32mcol_double()[39m
    )


    [1] "abc_data//abc2.csv"


    Parsed with column specification:
    cols(
      a = [32mcol_double()[39m,
      d = [32mcol_double()[39m,
      e = [32mcol_double()[39m
    )



<dl>
	<dt>[[1]]</dt>
		<dd>NULL</dd>
	<dt>[[2]]</dt>
		<dd>NULL</dd>
	<dt>$abc.csv</dt>
		<dd><table>
<caption>A spec_tbl_df: 10 × 3</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td> 1</td><td> 2</td><td>  4</td></tr>
	<tr><td> 2</td><td> 4</td><td> 16</td></tr>
	<tr><td> 3</td><td> 6</td><td> 28</td></tr>
	<tr><td> 4</td><td> 8</td><td> 40</td></tr>
	<tr><td> 5</td><td>10</td><td> 52</td></tr>
	<tr><td> 6</td><td>12</td><td> 64</td></tr>
	<tr><td> 7</td><td>14</td><td> 76</td></tr>
	<tr><td> 8</td><td>16</td><td> 88</td></tr>
	<tr><td> 9</td><td>18</td><td>100</td></tr>
	<tr><td>10</td><td>20</td><td>112</td></tr>
</tbody>
</table>
</dd>
	<dt>$abc2.csv</dt>
		<dd><table>
<caption>A spec_tbl_df: 10 × 3</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>d</th><th scope=col>e</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td> 1</td><td> 3</td><td> 4</td></tr>
	<tr><td> 2</td><td> 9</td><td> 8</td></tr>
	<tr><td> 3</td><td>15</td><td>12</td></tr>
	<tr><td> 4</td><td>21</td><td>16</td></tr>
	<tr><td> 5</td><td>27</td><td>20</td></tr>
	<tr><td> 6</td><td>33</td><td>24</td></tr>
	<tr><td> 7</td><td>39</td><td>28</td></tr>
	<tr><td> 8</td><td>45</td><td>32</td></tr>
	<tr><td> 9</td><td>51</td><td>36</td></tr>
	<tr><td>10</td><td>57</td><td>40</td></tr>
</tbody>
</table>
</dd>
</dl>




<table>
<caption>A spec_tbl_df: 20 × 5</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th><th scope=col>d</th><th scope=col>e</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td> 1</td><td> 2</td><td>  4</td><td>NA</td><td>NA</td></tr>
	<tr><td> 2</td><td> 4</td><td> 16</td><td>NA</td><td>NA</td></tr>
	<tr><td> 3</td><td> 6</td><td> 28</td><td>NA</td><td>NA</td></tr>
	<tr><td> 4</td><td> 8</td><td> 40</td><td>NA</td><td>NA</td></tr>
	<tr><td> 5</td><td>10</td><td> 52</td><td>NA</td><td>NA</td></tr>
	<tr><td> 6</td><td>12</td><td> 64</td><td>NA</td><td>NA</td></tr>
	<tr><td> 7</td><td>14</td><td> 76</td><td>NA</td><td>NA</td></tr>
	<tr><td> 8</td><td>16</td><td> 88</td><td>NA</td><td>NA</td></tr>
	<tr><td> 9</td><td>18</td><td>100</td><td>NA</td><td>NA</td></tr>
	<tr><td>10</td><td>20</td><td>112</td><td>NA</td><td>NA</td></tr>
	<tr><td> 1</td><td>NA</td><td> NA</td><td> 3</td><td> 4</td></tr>
	<tr><td> 2</td><td>NA</td><td> NA</td><td> 9</td><td> 8</td></tr>
	<tr><td> 3</td><td>NA</td><td> NA</td><td>15</td><td>12</td></tr>
	<tr><td> 4</td><td>NA</td><td> NA</td><td>21</td><td>16</td></tr>
	<tr><td> 5</td><td>NA</td><td> NA</td><td>27</td><td>20</td></tr>
	<tr><td> 6</td><td>NA</td><td> NA</td><td>33</td><td>24</td></tr>
	<tr><td> 7</td><td>NA</td><td> NA</td><td>39</td><td>28</td></tr>
	<tr><td> 8</td><td>NA</td><td> NA</td><td>45</td><td>32</td></tr>
	<tr><td> 9</td><td>NA</td><td> NA</td><td>51</td><td>36</td></tr>
	<tr><td>10</td><td>NA</td><td> NA</td><td>57</td><td>40</td></tr>
</tbody>
</table>




<table>
<caption>A spec_tbl_df: 10 × 6</caption>
<thead>
	<tr><th scope=col>a</th><th scope=col>b</th><th scope=col>c</th><th scope=col>a1</th><th scope=col>d</th><th scope=col>e</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td> 1</td><td> 2</td><td>  4</td><td> 1</td><td> 3</td><td> 4</td></tr>
	<tr><td> 2</td><td> 4</td><td> 16</td><td> 2</td><td> 9</td><td> 8</td></tr>
	<tr><td> 3</td><td> 6</td><td> 28</td><td> 3</td><td>15</td><td>12</td></tr>
	<tr><td> 4</td><td> 8</td><td> 40</td><td> 4</td><td>21</td><td>16</td></tr>
	<tr><td> 5</td><td>10</td><td> 52</td><td> 5</td><td>27</td><td>20</td></tr>
	<tr><td> 6</td><td>12</td><td> 64</td><td> 6</td><td>33</td><td>24</td></tr>
	<tr><td> 7</td><td>14</td><td> 76</td><td> 7</td><td>39</td><td>28</td></tr>
	<tr><td> 8</td><td>16</td><td> 88</td><td> 8</td><td>45</td><td>32</td></tr>
	<tr><td> 9</td><td>18</td><td>100</td><td> 9</td><td>51</td><td>36</td></tr>
	<tr><td>10</td><td>20</td><td>112</td><td>10</td><td>57</td><td>40</td></tr>
</tbody>
</table>




```R
# 编写一个函数，使其输出一个数据框中所有数值列的均值及名称
show_mean <- function(x){
    for (i in names(x)){
        if(is.numeric(x[[i]])){
        mn <- mean(x[[i]])
#         print(i)
        cat(i, ":" , format(mn, digits = 2, nsmall = 2), "\n", sep = "")
        }# format用于格式化
    }
}
show_mean(iris)
# 目前只能写到这样

# 下面的是网上找到的，对齐了数值
show_mean2 <- function(df, digits = 2) {
  # Get max length of all variable names in the dataset
  maxstr <- max(str_length(names(df)))
  for (nm in names(df)) {
    if (is.numeric(df[[nm]])) {
      cat(
        str_c(str_pad(str_c(nm, ":"), maxstr + 1L, side = "right"),
              format(mean(df[[nm]]), digits = digits, nsmall = digits),
              sep = " "
        ),
        "\n"
      )
    }
  }
}
show_mean2(iris)
```

    Sepal.Length:5.84
    Sepal.Width:3.06
    Petal.Length:3.76
    Petal.Width:1.20
    Sepal.Length: 5.84 
    Sepal.Width:  3.06 
    Petal.Length: 3.76 
    Petal.Width:  1.20 



```R
head(mtcars)
trans <-list(  
    disp =function(x) x *0.0163871,   
    am =function(x) { 
        factor(x, labels =c("auto", "manual"))   
    } 
) 
for (var in names(trans)) {   
    mtcars[[var]] <- trans[[var]](mtcars[[var]]) 
}
head(mtcars)

# 对比一下能懂，写不出来
```


<table>
<caption>A data.frame: 6 × 11</caption>
<thead>
	<tr><th></th><th scope=col>mpg</th><th scope=col>cyl</th><th scope=col>disp</th><th scope=col>hp</th><th scope=col>drat</th><th scope=col>wt</th><th scope=col>qsec</th><th scope=col>vs</th><th scope=col>am</th><th scope=col>gear</th><th scope=col>carb</th></tr>
	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>Mazda RX4</th><td>21.0</td><td>6</td><td>160</td><td>110</td><td>3.90</td><td>2.620</td><td>16.46</td><td>0</td><td>1</td><td>4</td><td>4</td></tr>
	<tr><th scope=row>Mazda RX4 Wag</th><td>21.0</td><td>6</td><td>160</td><td>110</td><td>3.90</td><td>2.875</td><td>17.02</td><td>0</td><td>1</td><td>4</td><td>4</td></tr>
	<tr><th scope=row>Datsun 710</th><td>22.8</td><td>4</td><td>108</td><td> 93</td><td>3.85</td><td>2.320</td><td>18.61</td><td>1</td><td>1</td><td>4</td><td>1</td></tr>
	<tr><th scope=row>Hornet 4 Drive</th><td>21.4</td><td>6</td><td>258</td><td>110</td><td>3.08</td><td>3.215</td><td>19.44</td><td>1</td><td>0</td><td>3</td><td>1</td></tr>
	<tr><th scope=row>Hornet Sportabout</th><td>18.7</td><td>8</td><td>360</td><td>175</td><td>3.15</td><td>3.440</td><td>17.02</td><td>0</td><td>0</td><td>3</td><td>2</td></tr>
	<tr><th scope=row>Valiant</th><td>18.1</td><td>6</td><td>225</td><td>105</td><td>2.76</td><td>3.460</td><td>20.22</td><td>1</td><td>0</td><td>3</td><td>1</td></tr>
</tbody>
</table>




<table>
<caption>A data.frame: 6 × 11</caption>
<thead>
	<tr><th></th><th scope=col>mpg</th><th scope=col>cyl</th><th scope=col>disp</th><th scope=col>hp</th><th scope=col>drat</th><th scope=col>wt</th><th scope=col>qsec</th><th scope=col>vs</th><th scope=col>am</th><th scope=col>gear</th><th scope=col>carb</th></tr>
	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>Mazda RX4</th><td>21.0</td><td>6</td><td>2.621936</td><td>110</td><td>3.90</td><td>2.620</td><td>16.46</td><td>0</td><td>manual</td><td>4</td><td>4</td></tr>
	<tr><th scope=row>Mazda RX4 Wag</th><td>21.0</td><td>6</td><td>2.621936</td><td>110</td><td>3.90</td><td>2.875</td><td>17.02</td><td>0</td><td>manual</td><td>4</td><td>4</td></tr>
	<tr><th scope=row>Datsun 710</th><td>22.8</td><td>4</td><td>1.769807</td><td> 93</td><td>3.85</td><td>2.320</td><td>18.61</td><td>1</td><td>manual</td><td>4</td><td>1</td></tr>
	<tr><th scope=row>Hornet 4 Drive</th><td>21.4</td><td>6</td><td>4.227872</td><td>110</td><td>3.08</td><td>3.215</td><td>19.44</td><td>1</td><td>auto  </td><td>3</td><td>1</td></tr>
	<tr><th scope=row>Hornet Sportabout</th><td>18.7</td><td>8</td><td>5.899356</td><td>175</td><td>3.15</td><td>3.440</td><td>17.02</td><td>0</td><td>auto  </td><td>3</td><td>2</td></tr>
	<tr><th scope=row>Valiant</th><td>18.1</td><td>6</td><td>3.687098</td><td>105</td><td>2.76</td><td>3.460</td><td>20.22</td><td>1</td><td>auto  </td><td>3</td><td>1</td></tr>
</tbody>
</table>



## for循环与函数式编程

for循环在R中不像在其他语言中那么重要，因为R是一门函数式编程语言。这意味着可以先将for循环包装在函数中，然后再调用这个函数，而不是直接使用for循环。


```R
# 还是老例子

df <- tibble(
    a = rnorm(10),
    b = rnorm(10),
    c = rnorm(10),
    d = rnorm(10)
)

# 计算均值
output <- vector("double", length(df))
for (i in seq_along(df)) {
    output[[i]] <- mean(df[[i]])
}
output

# 将for循环包装进函数
col_mean <- function(df){
    output <- vector("double", length(df))
    for (i in seq_along(df)) {
        output[[i]] <- mean(df[[i]])
    }
    output
}

col_mean(df)

# 计算中位数
col_median <- function(df){
    output <- vector("double", length(df))
    for (i in seq_along(df)) {
        output[[i]] <- median(df[[i]])
    }
    output
}
col_median(df)

# 计算标准差
col_sd <- function(df){
    output <- vector("double", length(df))
    for (i in seq_along(df)) {
        output[[i]] <- sd(df[[i]])
    }
    output
}
col_sd(df)

# 我们又复制了两次
```


<ol class=list-inline>
	<li>-0.0691737424348837</li>
	<li>0.189403079594602</li>
	<li>0.026400624604292</li>
	<li>0.490374176541561</li>
</ol>




<ol class=list-inline>
	<li>-0.0691737424348837</li>
	<li>0.189403079594602</li>
	<li>0.026400624604292</li>
	<li>0.490374176541561</li>
</ol>




<ol class=list-inline>
	<li>-0.0923123945154875</li>
	<li>0.513887237083275</li>
	<li>0.345117798467214</li>
	<li>0.565390015450605</li>
</ol>




<ol class=list-inline>
	<li>0.90800827543933</li>
	<li>1.14091855303405</li>
	<li>1.08706849760068</li>
	<li>0.888396286300644</li>
</ol>




```R
# 让我们扩展一下我们的函数
col_summary <- function(df, fun){
    output <- vector("double", length(df))
    for (i in seq_along(df)) {
        output[[i]] <- fun(df[[i]])
    }
    output
}# 为函数增加了一个参数，将函数作为参数传入另一个函数，以便实现功能
col_summary(df, median)
col_summary(df, mean)
```


<ol class=list-inline>
	<li>-0.0923123945154875</li>
	<li>0.513887237083275</li>
	<li>0.345117798467214</li>
	<li>0.565390015450605</li>
</ol>




<ol class=list-inline>
	<li>-0.0691737424348837</li>
	<li>0.189403079594602</li>
	<li>0.026400624604292</li>
	<li>0.490374176541561</li>
</ol>



> 在本章剩余部分，我们将学习和使用purrr包，它提供的函数可以替代很多常见的for循环应用。R基础包中的应用函数族（apply()、lapply()、tapply()等）也可以完成类似的任务，但purrr包中的函数更一致，也更易于学习。

大佬说的


```R
col_summary <- function(df, fun){
    output <- vector("double", length(df))
    for (i in seq_along(df)) {
        if(is.numeric(df[[i]])){
        output[[i]] <- fun(df[[i]])
            }
        }
    output
}# 加个判断不如不加吧

col_summary(iris, mean)
```


<ol class=list-inline>
	<li>5.84333333333333</li>
	<li>3.05733333333333</li>
	<li>3.758</li>
	<li>1.19933333333333</li>
	<li>0</li>
</ol>



## 映射函数

* map()用于输出列表；
* map_lgl()用于输出逻辑型向量；
* map_int()用于输出整型向量；
* map_dbl()用于输出双精度型向量；
* map_chr()用于输出字符型向量。

映射函数是一种高度抽象，需要花费很长时间才能理解其工作原理


```R
# 看摘要函数的例子
map_dbl(df, mean)
map_dbl(df, median)
# map_dbl(df, sd)# 这个容易报错
map_dbl(iris, mean)
```


<dl class=dl-horizontal>
	<dt>a</dt>
		<dd>-0.0691737424348837</dd>
	<dt>b</dt>
		<dd>0.189403079594602</dd>
	<dt>c</dt>
		<dd>0.026400624604292</dd>
	<dt>d</dt>
		<dd>0.490374176541561</dd>
</dl>




<dl class=dl-horizontal>
	<dt>a</dt>
		<dd>-0.0923123945154875</dd>
	<dt>b</dt>
		<dd>0.513887237083275</dd>
	<dt>c</dt>
		<dd>0.345117798467214</dd>
	<dt>d</dt>
		<dd>0.565390015450605</dd>
</dl>



    Warning message in mean.default(.x[[i]], ...):
    “argument is not numeric or logical: returning NA”


<dl class=dl-horizontal>
	<dt>Sepal.Length</dt>
		<dd>5.84333333333333</dd>
	<dt>Sepal.Width</dt>
		<dd>3.05733333333333</dd>
	<dt>Petal.Length</dt>
		<dd>3.758</dd>
	<dt>Petal.Width</dt>
		<dd>1.19933333333333</dd>
	<dt>Species</dt>
		<dd>&lt;NA&gt;</dd>
</dl>




```R
# 使用管道更明显
df %>% map_dbl(mean)
```


<dl class=dl-horizontal>
	<dt>a</dt>
		<dd>-0.0691737424348837</dd>
	<dt>b</dt>
		<dd>0.189403079594602</dd>
	<dt>c</dt>
		<dd>0.026400624604292</dd>
	<dt>d</dt>
		<dd>0.490374176541561</dd>
</dl>



purrr函数都是C语言实现的，速度特别快

第二个参数可以是公式、一个字符向量等


```R
map_dbl(df, mean, trim = 0.5)# 可以有附加参数
z <- list(x = 1:3, y = 4:5)
map_int(z, length)# 可以保留名称
```


<dl class=dl-horizontal>
	<dt>a</dt>
		<dd>-0.0923123945154875</dd>
	<dt>b</dt>
		<dd>0.513887237083275</dd>
	<dt>c</dt>
		<dd>0.345117798467214</dd>
	<dt>d</dt>
		<dd>0.565390015450605</dd>
</dl>




<dl class=dl-horizontal>
	<dt>x</dt>
		<dd>3</dd>
	<dt>y</dt>
		<dd>2</dd>
</dl>




```R
# 快捷方式

# 按照气缸拟合线性模型
models <- mtcars %>% split(.$cyl) %>% 
map(function(df) lm(mpg ~ wt, data = df))

# 可以使用单侧公式简化
models <- mtcars %>% split(.$cyl) %>%
map(~lm(mpg ~ wt, data = .))
# models
    
# 提取R^2

models %>% map(summary) %>% map_dbl(~ .$r.squared)

# 甚至可以使用字符串
models %>% map(summary) %>% map_dbl("r.squared")
    
# 还可以使用整数按照位置来选取元素：
x <-list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9)) 
x %>%map_dbl(2) 
```


<dl class=dl-horizontal>
	<dt>4</dt>
		<dd>0.50863259632314</dd>
	<dt>6</dt>
		<dd>0.464510150550548</dd>
	<dt>8</dt>
		<dd>0.422965536496111</dd>
</dl>




<dl class=dl-horizontal>
	<dt>4</dt>
		<dd>0.50863259632314</dd>
	<dt>6</dt>
		<dd>0.464510150550548</dd>
	<dt>8</dt>
		<dd>0.422965536496111</dd>
</dl>




<ol class=list-inline>
	<li>2</li>
	<li>5</li>
	<li>8</li>
</ol>




```R
### R基础包
# R基础包中也有应用函数族，像是lapply(), sapply(), vapply()

# sapply()函数是对lapply()的包装，可以自动简化输出。
# 这对交互工作是有用的，但作为函数则是有问题的，
# 因为你不知道会得到什么样的输出
x1 <-list( 
    c(0.27, 0.37, 0.57, 0.91, 0.20), 
    c(0.90, 0.94, 0.66, 0.63, 0.06),
    c(0.21, 0.18, 0.69, 0.38, 0.77) 
) 
x2 <-list( 
    c(0.50, 0.72, 0.99, 0.38, 0.78), 
    c(0.93, 0.21, 0.65, 0.13, 0.27), 
    c(0.39, 0.01, 0.38, 0.87, 0.34) 
) 
threshold <-function(x, cutoff =0.8) x[x > cutoff] 
x1 %>%sapply(threshold) %>%str() # 返回列表
x2 %>%sapply(threshold) %>%str()# 返回num
```

    List of 3
     $ : num 0.91
     $ : num [1:2] 0.9 0.94
     $ : num(0) 
     num [1:3] 0.99 0.93 0.87


vapply()函数是sapply()的一种安全替代方式，因为前者可以提供额外的参数来定义类型。vapply()的唯一缺点是输入量较大：vapply(df,  is.numeric,  logical(1))等价于map_lgl(df,  is.numeric)。


```R
# a.计算mtcars数据集中每列的均值
# head(mtcars)
map_dbl(mtcars, mean)
# b.确定nycflights13::flights数据集中每列的类型。
library(nycflights13)
# flights %>% str()
flights %>% map(class)
# c.计算iris数据集中每列唯一值的数量。
iris %>% map_int(~length(unique(.)))
# d.分别使用μ= -10、0、10和100的正态分布生成10个随机数。
mu <- list(-10, 0, 10, 100)
mu %>% map(~rnorm(n = 10, mean = .))
```

    Warning message in mean.default(.x[[i]], ...):
    “argument is not numeric or logical: returning NA”


<dl class=dl-horizontal>
	<dt>mpg</dt>
		<dd>20.090625</dd>
	<dt>cyl</dt>
		<dd>6.1875</dd>
	<dt>disp</dt>
		<dd>3.7808624378125</dd>
	<dt>hp</dt>
		<dd>146.6875</dd>
	<dt>drat</dt>
		<dd>3.5965625</dd>
	<dt>wt</dt>
		<dd>3.21725</dd>
	<dt>qsec</dt>
		<dd>17.84875</dd>
	<dt>vs</dt>
		<dd>0.4375</dd>
	<dt>am</dt>
		<dd>&lt;NA&gt;</dd>
	<dt>gear</dt>
		<dd>3.6875</dd>
	<dt>carb</dt>
		<dd>2.8125</dd>
</dl>




<dl>
	<dt>$year</dt>
		<dd>'integer'</dd>
	<dt>$month</dt>
		<dd>'integer'</dd>
	<dt>$day</dt>
		<dd>'integer'</dd>
	<dt>$dep_time</dt>
		<dd>'integer'</dd>
	<dt>$sched_dep_time</dt>
		<dd>'integer'</dd>
	<dt>$dep_delay</dt>
		<dd>'numeric'</dd>
	<dt>$arr_time</dt>
		<dd>'integer'</dd>
	<dt>$sched_arr_time</dt>
		<dd>'integer'</dd>
	<dt>$arr_delay</dt>
		<dd>'numeric'</dd>
	<dt>$carrier</dt>
		<dd>'character'</dd>
	<dt>$flight</dt>
		<dd>'integer'</dd>
	<dt>$tailnum</dt>
		<dd>'character'</dd>
	<dt>$origin</dt>
		<dd>'character'</dd>
	<dt>$dest</dt>
		<dd>'character'</dd>
	<dt>$air_time</dt>
		<dd>'numeric'</dd>
	<dt>$distance</dt>
		<dd>'numeric'</dd>
	<dt>$hour</dt>
		<dd>'numeric'</dd>
	<dt>$minute</dt>
		<dd>'numeric'</dd>
	<dt>$time_hour</dt>
		<dd><ol class=list-inline>
	<li>'POSIXct'</li>
	<li>'POSIXt'</li>
</ol>
</dd>
</dl>




<dl class=dl-horizontal>
	<dt>Sepal.Length</dt>
		<dd>35</dd>
	<dt>Sepal.Width</dt>
		<dd>23</dd>
	<dt>Petal.Length</dt>
		<dd>43</dd>
	<dt>Petal.Width</dt>
		<dd>22</dd>
	<dt>Species</dt>
		<dd>3</dd>
</dl>




<ol>
	<li><ol class=list-inline>
	<li>-7.61178690221624</li>
	<li>-9.62020979118412</li>
	<li>-8.21119612202838</li>
	<li>-10.3045730867521</li>
	<li>-11.4461730864789</li>
	<li>-9.61159153966673</li>
	<li>-10.6294065693388</li>
	<li>-10.2867625512788</li>
	<li>-10.525487000336</li>
	<li>-9.48203186609093</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>-0.292348269190166</li>
	<li>-0.244951190508629</li>
	<li>-0.169692692892563</li>
	<li>-0.399224871825663</li>
	<li>0.33072608541756</li>
	<li>0.588909491250073</li>
	<li>-0.489534376718707</li>
	<li>-0.704906375187525</li>
	<li>1.17590841100481</li>
	<li>-0.0866991258351262</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>10.4521582385986</li>
	<li>8.03884932613253</li>
	<li>11.8623163880673</li>
	<li>8.73210111922027</li>
	<li>10.556674614529</li>
	<li>10.6720775955732</li>
	<li>10.377434711092</li>
	<li>8.82637912847465</li>
	<li>9.49949438782754</li>
	<li>9.96808401033364</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>99.7525662520464</li>
	<li>97.7737797372444</li>
	<li>103.221900701538</li>
	<li>99.2752620277251</li>
	<li>99.0542699693914</li>
	<li>99.8151944908271</li>
	<li>100.405113573576</li>
	<li>99.4944585470587</li>
	<li>101.504723890361</li>
	<li>99.4633413717159</li>
</ol>
</li>
</ol>




```R
# 如果在非列表向量上使用映射函数，那么会发生什么情况？
# map(1:5,  runif)的作用是什么？为什么？
map(1:5, runif)# 作为参数输入
```


<ol>
	<li>0.00581031921319664</li>
	<li><ol class=list-inline>
	<li>0.469833726761863</li>
	<li>0.174555057426915</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>0.675424233544618</li>
	<li>0.182182345306501</li>
	<li>0.546054564649239</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>0.223653354449198</li>
	<li>0.138208583928645</li>
	<li>0.579780279193074</li>
	<li>0.31526015419513</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>0.559682150371373</li>
	<li>0.068848526570946</li>
	<li>0.350577338598669</li>
	<li>0.352343474514782</li>
	<li>0.386256132042035</li>
</ol>
</li>
</ol>




```R
# map(-2:2, rnorm, n = 5)的作用是什么？为什么？
# map_dbl(-2:2, rnorm, n = 5)的作用又是什么？为什么？
map(-2:2, rnorm, n = 5)# 作为第二个参数导入
# map_dbl(-2:2, rnorm, n = 5)# 报错
```


<ol>
	<li><ol class=list-inline>
	<li>-2.14142464968772</li>
	<li>-4.4853794702427</li>
	<li>-1.59646697149563</li>
	<li>-1.66558105310495</li>
	<li>-1.97815616812872</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>0.907359865449551</li>
	<li>-1.76090281145307</li>
	<li>0.173990067294692</li>
	<li>-0.885595220165182</li>
	<li>-2.03525419922009</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>-0.895423091502646</li>
	<li>-0.163401094764929</li>
	<li>-0.613834466531499</li>
	<li>1.17060696395874</li>
	<li>0.231809385468989</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>0.493381205606247</li>
	<li>0.370603132850885</li>
	<li>0.642941281217797</li>
	<li>0.597108601314557</li>
	<li>0.432752002570071</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>2.50199423709977</li>
	<li>2.54800133149241</li>
	<li>0.714398097696883</li>
	<li>2.07681607118511</li>
	<li>1.5016552936112</li>
</ol>
</li>
</ol>



## 对操作失败的处理

safely(),transpose(),possibly(),quietly()函数

这四个函数对失败的处理不同，书上写的很明白

## 多参数映射


```R
# 模拟均值不同的随机正态分布
mu <- list(5, 10, -3)
mu %>% map(rnorm, n = 5) %>% str()

# 如果还想让标准差也不同呢？

# 一种方法是用索引进行迭代
sigma <- list(1, 5, 10)
seq_along(mu) %>% map(~rnorm(5, mu[[.]], sigma[[.]])) %>% str()

# 另一种方法是使用map2函数，它对两个向量进行同步迭代
map2(mu, sigma, rnorm, n = 5) %>% str()

# 如果是样本数量也不同呢？
# pmap()函数可以将一个列表作为参数
n <- list(1, 3, 5)
args1 <- list(n, mu, sigma)
args1 %>% pmap(rnorm) %>% str()

# 这样没有命名容易出错，且可读性差

# 命名后的代码如下
args2 <- list(mean = mu, sd = sigma, n = n)
args2 %>% pmap(rnorm) %>%  str()
```

    List of 3
     $ : num [1:5] 5.57 4.53 4.08 5.19 5.11
     $ : num [1:5] 10.53 8.59 10.27 9.51 10.19
     $ : num [1:5] -2.1 -4.26 -3.36 -2.24 -3.1
    List of 3
     $ : num [1:5] 4.85 4.91 2.89 5.02 4.64
     $ : num [1:5] 6.49 9.5 9.03 7.81 16.93
     $ : num [1:5] 0.712 -8.34 -21.278 7.161 -22.743
    List of 3
     $ : num [1:5] 4.71 3.81 5.35 6.84 5.24
     $ : num [1:5] 14.5 14 9.4 11.4 10.2
     $ : num [1:5] 2.71 -5.11 -8.06 -3.08 -9.77
    List of 3
     $ : num 4.29
     $ : num [1:3] 10.18 6.45 7.7
     $ : num [1:5] -7.16 3.3 13.64 -9.74 13.5
    List of 3
     $ : num 3.77
     $ : num [1:3] 16.8 11.1 11.4
     $ : num [1:5] -23.5 -6.68 -2.24 2.79 -20.53



```R
# 因为长度都是相同的，所以可以将各个参数保存在一个数据框中：
params <-tribble( 
    ~mean, ~sd, ~n, 
    5,     1,  1, 
    10,    5,  3, 
    -3,    10,  5
) 
params %>% pmap(rnorm)
```


<ol>
	<li>3.7629252728007</li>
	<li><ol class=list-inline>
	<li>13.8120767590046</li>
	<li>6.35297596000443</li>
	<li>10.8368808594292</li>
</ol>
</li>
	<li><ol class=list-inline>
	<li>-7.32624883247804</li>
	<li>-1.29299588807772</li>
	<li>-5.83324200434657</li>
	<li>-12.4415451854882</li>
	<li>-6.15911055388429</li>
</ol>
</li>
</ol>




```R
# 再复杂点是调用不同函数
f <- c("runif", "rnorm", "rpois") 
param <-list( 
    list(min =-1, max =1), 
    list(sd =5), 
    list(lambda =10) 
)
# 使用invoke_map()函数
invoke_map(f, param, n = 5) %>% str()

# 也可以使用数据框
sim <-tribble( 
    ~f,      ~params, 
    "runif", list(min =-1, max =1), 
    "rnorm", list(sd =5), 
    "rpois", list(lambda =10) ) 

sim %>% mutate(sim = invoke_map(f, params, n = 10))
```

    List of 3
     $ : num [1:5] 0.0959 0.7964 0.469 -0.5055 -0.1469
     $ : num [1:5] -12.79 3.43 -3.89 5.46 -2.46
     $ : int [1:5] 5 5 11 12 6



<table>
<caption>A tibble: 3 × 3</caption>
<thead>
	<tr><th scope=col>f</th><th scope=col>params</th><th scope=col>sim</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;list&gt;</th><th scope=col>&lt;list&gt;</th></tr>
</thead>
<tbody>
	<tr><td>runif</td><td>-1, 1</td><td>0.8064592, -0.5800157, -0.8758826, 0.1162058, -0.4481403, -0.5444552, -0.2009330, 0.8922024, 0.6315626, 0.3517507</td></tr>
	<tr><td>rnorm</td><td>5</td><td>-6.9614559, 1.7678565, 7.4130429, -4.1046393, 1.2004052, -3.5973553, -3.0707497, -2.4898078, -3.6925922, 0.4619668</td></tr>
	<tr><td>rpois</td><td>10</td><td>6, 14, 11, 12, 10, 12, 3, 11, 12, 17</td></tr>
</tbody>
</table>



## 游走函数

使用这个函数的目的是在屏幕上提供输出或者将文件保存到磁盘——重要的是操作过程，而不是返回值。


```R
# 简单例子
x <- list(1, "a", 3)
x %>% walk(print)
```

    [1] 1
    [1] "a"
    [1] 3



```R
# pwalk保存文件
library(ggplot2)
plots <- mtcars %>% split(.$cyl) %>%
    map(~ggplot(., aes(mpg, wt)) + geom_point())
paths <- str_c(names(plots), ".pdf")
# plots
pwalk(list(paths, plots), ggsave, path = tempdir())
# tempdir()函数表示获得临时目录
tempdir()
```

    Saving 6.67 x 6.67 in image
    Saving 6.67 x 6.67 in image
    Saving 6.67 x 6.67 in image



'/tmp/RtmpwnsVEU'


## for循环的其他模式


```R
# 预测函数
iris %>% keep(is.factor) %>% str()# keep 保留为T的元素
iris %>% discard(is.factor) %>% str()# discard保留为F的元素

x <- list(1:5, letters, list(10))

x %>% some(is_character)# 部分为真
x %>% every(is_vector)# 全部为真
```

    'data.frame':	150 obs. of  1 variable:
     $ Species: Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
    'data.frame':	150 obs. of  4 variables:
     $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
     $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
     $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
     $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...



TRUE



TRUE



```R
# detect()函数可以找出预测值为真的第一个元素，
# detect_index()函数则可以返回这个元素的位置：

x <- sample(10)
x %>% t()
x %>% detect(~ . > 5)
x %>% detect_index(~ . > 5)
# head_while()和tail_while()分别从向量的开头和结尾找出预测值为真的元素：

x %>% head_while(~ . > 5)
x %>% tail_while(~ . > 5)
```


<table>
<caption>A matrix: 1 × 10 of type int</caption>
<tbody>
	<tr><td>7</td><td>10</td><td>4</td><td>3</td><td>2</td><td>6</td><td>5</td><td>1</td><td>8</td><td>9</td></tr>
</tbody>
</table>




7



1



<ol class=list-inline>
	<li>7</li>
	<li>10</li>
</ol>




<ol class=list-inline>
	<li>8</li>
	<li>9</li>
</ol>




```R
# # 归约与累计
# reduce()函数使用一个“二元”函数（即具有两个基本输入的函数），
# 将其不断应用于一个列表，直到最后只剩下一个元素为止。
dfs <- list(   
    age =tibble(name ="John", age =30),   
    sex =tibble(name =c("John", "Mary"), sex =c("M", "F")),   
    trt =tibble(name ="Mary", treatment ="A") ) 
dfs %>% reduce(full_join)# 合并表

vs <- list( 
    c(1, 3, 5, 6, 10), 
    c(1, 2, 3, 7, 8, 10), 
    c(1, 2, 3, 4, 8, 9, 10) 
    )
vs %>% reduce(intersect)# 找交集

# 累计函数与归约函数很相似，但前者会保留所有中间结果。你可以使用它来实现累计求和：

x <- sample(10)
x %>% accumulate(`+`) %>% t()
```

    Joining, by = "name"
    Joining, by = "name"



<table>
<caption>A tibble: 2 × 4</caption>
<thead>
	<tr><th scope=col>name</th><th scope=col>age</th><th scope=col>sex</th><th scope=col>treatment</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>John</td><td>30</td><td>M</td><td>NA</td></tr>
	<tr><td>Mary</td><td>NA</td><td>F</td><td>A </td></tr>
</tbody>
</table>




<ol class=list-inline>
	<li>1</li>
	<li>3</li>
	<li>10</li>
</ol>




<table>
<caption>A matrix: 1 × 10 of type int</caption>
<tbody>
	<tr><td>9</td><td>16</td><td>21</td><td>25</td><td>33</td><td>39</td><td>40</td><td>50</td><td>52</td><td>55</td></tr>
</tbody>
</table>


