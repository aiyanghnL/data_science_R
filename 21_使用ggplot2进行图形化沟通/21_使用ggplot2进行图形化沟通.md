# 使用ggplot2进行图形化沟通

第一章就是关于ggplot2绘图的，这里还是关于ggplot2，不过和前面不一样。

此外这里需要安装ggrepel和viridis包。


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


## 标签


```R
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
geom_smooth(se = F) + labs(
    title = paste("Fuel efficiency generally descrases with",
                 "engine size"
                 )
)# 书上有点小错误
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_3_1.png)



```R
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
geom_smooth(se = F) + labs(
    title = paste("Fuel efficiency generally descrases with",
                 "engine size"
                 ),
    subtitle = paste(# 添加子标题
        "Two seaters (sports cars) are an exception",
        "because of their light")
)
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_4_1.png)



```R
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
geom_smooth(se = F) + labs(
    title = paste("Fuel efficiency generally descrases with",
                 "engine size"
                 ),
    subtitle = paste(# 添加子标题
        "Two seaters (sports cars) are an exception",
        "because of their light"),
    caption = "Date from fueleconomy.gov"# 右下角添加数据来源
)
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_5_1.png)



```R
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
geom_smooth(se = F) + labs(
    title = paste("Fuel efficiency generally descrases with",
                 "engine size"
                 ),
    subtitle = paste(# 添加子标题
        "Two seaters (sports cars) are an exception",
        "because of their light"),
    caption = "Date from fueleconomy.gov",# 右下角添加数据来源
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",# 修改坐标轴
    color = "Car type"# 修改图例
)
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_6_1.png)



```R
# 使用数学公式
df <- tibble(
    x = runif(10),
    y = runif(10)
)

ggplot(df, aes(x, y)) + geom_point() + 
labs(
    x = quote(sum(x[i] ^ 2, i == 1, n)),
    y = quote(alpha + beta + frac(delta, theta))
)
```


![png](output_7_0.png)



```R
# 使用数学公式
df <- tibble(
    x = runif(10),
    y = runif(10)
)

library(latex2exp)
ggplot(df, aes(x, y)) + geom_point() + 
labs(
    x = TeX("$\\sum_{i=1}^{n} x_i^2$"),
    y = TeX("$\\alpha + \\beta + \\frac{\\delta}{\\theta}$")
)# 这里使用TeX语法写的公式，需要安装latex2exp包
```


![png](output_8_0.png)


## 注释


```R
# geom_text版

best_in_class <- mpg %>% group_by(class) %>%
    filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) + 
    geom_point(aes(color = class)) + 
    geom_text(aes(label = model), data = best_in_class)
```


![png](output_10_0.png)



```R
# geom_label版
ggplot(mpg, aes(displ, hwy)) + 
    geom_point(aes(color = class)) + 
    geom_label(
        aes(label = model),
        data = best_in_class,
        nudge_y = 2,
        alpha = 0.5
    )
```


![png](output_11_0.png)



```R
# 利用ggrepel包
ggplot(mpg, aes(displ,  hwy)) + 
    geom_point(aes(color = class)) + 
    geom_point(size = 3, shape = 1, data = best_in_class) + 
    ggrepel::geom_label_repel(
        aes(label = model),
        data = best_in_class
    )
```


![png](output_12_0.png)


终于不重叠了


```R
# 将标签直接放在图上以代替图列
class_avg <- mpg %>% group_by(class) %>%
    summarise(
        displ = median(displ),
        hwy = median(hwy)
    )
ggplot(mpg, aes(displ, hwy, color = class)) + 
    ggrepel::geom_label_repel(aes(label = class),
        data = class_avg,
        size = 6,
        label.size = 0,
        segment.color = NA
    ) + 
geom_point() + 
theme(legend.position = "none")
```


![png](output_14_0.png)



```R
# 添加位于角落的单独标签
label <- mpg %>% 
    summarise(
        displ = max(displ),
        hwy = max(hwy),
        label = paste(
            "Increasing engine size is \nrelated to",
            "decreasing fuel economy."
        )
    )
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_text(
        aes(label = label),
        data = label,
        vjust = "top",
        hjust = "right"# 右对齐
    )
```


![png](output_15_0.png)



```R
# 添加位于右上角的单独标签
label <- mpg %>% 
    summarise(
        displ = Inf,
        hwy = Inf,
        label = paste(
            "Increasing engine size is \nrelated to",
            "decreasing fuel economy."
        )
    )
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_text(
        aes(label = label),
        data = label,
        vjust = "top",
        hjust = "right"# 右对齐
    )
```


![png](output_16_0.png)



```R
# 使用stringr::str_wrap()函数来自动换行
"Increasing engine size related to decreasing fuel economy."%>%  
stringr::str_wrap(width =40) %>%
writeLines() 
```

    Increasing engine size related to
    decreasing fuel economy.



```R
# 使用geom_text()函数和无穷大参数值将文本标签放置在图形的4个角落。
label2 <- tibble(        
        displ = c(Inf,Inf,-Inf,-Inf),
        hwy = c(-Inf,Inf,Inf,-Inf),
        vjust = c("bottom","top","top","bottom"),
        hjust = c("right","right","left","left"),
        label = "Increasing engine size related to decreasing fuel economy."%>%  
            stringr::str_wrap(width =40) 
    )

vjust = c("bottom","top","top","bottom")
hjust = c("right","right","left","left")

ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_text(
        aes(label = label),
        data = label2,
        vjust = vjust,
        hjust = hjust
    ) 
```


![png](output_18_0.png)



```R
# 阅读annotate()函数的文档。不创建tibble的情况下，如何使用这个函数为图形添加一个文本标签？
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    annotate("text", x = 5, y = 30, label = "some text")
# 详细看帮助，可以添加文本和形状，通过绝对位置添加
```


![png](output_19_0.png)



```R
ggplot(mpg, aes(displ, hwy)) + 
    geom_point(aes(color = class)) + 
    geom_label(
        aes(label = model),
        data = best_in_class,
        nudge_y = 2,
        alpha = 0.5
    )
```


![png](output_20_0.png)


## 标度


```R
# 一般情况下，ggplot2会自动向图表中添加标度。
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class))
# 等于下面的
ggplot(mpg, aes(displ, hwy)) +
geom_point(aes(color = class)) +
scale_x_continuous() +
scale_y_continuous() +
scale_color_discrete()
```


![png](output_22_0.png)



![png](output_22_1.png)



```R
ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_y_continuous(breaks =seq(15, 40, by =5))
# 设置Y轴标度
```


![png](output_23_0.png)



```R
ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_y_continuous(breaks =seq(15, 40, by =5), labels = letters[1:6])
# 利用labels将数值标度改为字母
```


![png](output_24_0.png)



```R
ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_x_continuous(labels =NULL) +
    scale_y_continuous(labels =NULL)
# 将labels设置为NULL，这样可以不显示刻度标签
```


![png](output_25_0.png)



```R
presidential %>% head()
# 不熟悉的数据先看一下
presidential %>% mutate(id = 33 + row_number()) %>% 
ggplot(aes(start, id)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_x_date(
        NULL,
        breaks = presidential$start,
        date_labels = "%y"
        # 以2位显示年份，大写Y以4位显示年份，可以看前面关于时间日期的格式化
    )
```


<table>
<caption>A tibble: 6 × 4</caption>
<thead>
	<tr><th scope=col>name</th><th scope=col>start</th><th scope=col>end</th><th scope=col>party</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Eisenhower</td><td>1953-01-20</td><td>1961-01-20</td><td>Republican</td></tr>
	<tr><td>Kennedy   </td><td>1961-01-20</td><td>1963-11-22</td><td>Democratic</td></tr>
	<tr><td>Johnson   </td><td>1963-11-22</td><td>1969-01-20</td><td>Democratic</td></tr>
	<tr><td>Nixon     </td><td>1969-01-20</td><td>1974-08-09</td><td>Republican</td></tr>
	<tr><td>Ford      </td><td>1974-08-09</td><td>1977-01-20</td><td>Republican</td></tr>
	<tr><td>Carter    </td><td>1977-01-20</td><td>1981-01-20</td><td>Democratic</td></tr>
</tbody>
</table>




![png](output_26_1.png)



```R
# 图例布局
# 使用theme函数
base <-ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class))
base
base +theme(legend.position ="left") 
base +theme(legend.position ="top") 
base +theme(legend.position ="bottom") 
base +theme(legend.position ="right") # 默认设置
base +theme(legend.position ="none") # 空
```


![png](output_27_0.png)



![png](output_27_1.png)



![png](output_27_2.png)



![png](output_27_3.png)



![png](output_27_4.png)



![png](output_27_5.png)



```R
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se =FALSE) +
    theme(legend.position ="bottom") +
    guides(     
        color =guide_legend(       
            nrow =1, # 显示为一行      
            override.aes =list(size =4)# 增大图例数据点
        )   
    )
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_28_1.png)



```R
# 标度替换
ggplot(diamonds, aes(carat, price)) +
    geom_bin2d() 
# 看不出关系
ggplot(diamonds, aes(log10(carat), log10(price))) +
    geom_bin2d() 
# 对数转换
# 缺点是坐标轴的值变了

# 标度转换
ggplot(diamonds, aes(carat, price)) +
    geom_bin2d() +
    scale_x_log10() +
    scale_y_log10()
```


![png](output_29_0.png)



![png](output_29_1.png)



![png](output_29_2.png)



```R
# 定制颜色
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = drv)) 
# 后者颜色对比更强烈
ggplot(mpg, aes(displ, hwy)) + 
    geom_point(aes(color = drv)) +
    scale_color_brewer(palette = "Set1") +　# 使用ColorBrewer标度
    guides(     
        color =guide_legend(       
#             ncol =1, # 显示为一行      
            override.aes =list(size =4)# 增大图例数据点
        )
)
```


![png](output_30_0.png)



![png](output_30_1.png)



```R

ggplot(mpg, aes(displ, hwy)) + 
    geom_point(aes(color = drv, shape = drv)) + # 添加形状
    scale_color_brewer(palette = "Set1") +　# 使用ColorBrewer标度
    guides(     
        color =guide_legend(       
#             ncol =1, # 显示为一行      
            override.aes =list(size =4)# 增大图例数据点
        )
)
```


![png](output_31_0.png)



```R
presidential %>%
    mutate(id =33+row_number()) %>%
    ggplot(aes(start, id, color = party)) +
        geom_point() +
        geom_segment(aes(xend = end, yend = id)) +
        scale_colour_manual(       
            values =c(Republican ="red", Democratic ="blue")# 手动指定颜色
        )
```


![png](output_32_0.png)


对于连续的颜色标度，我们可以使用内置函数scale_color_gradient()或scale_fill_gradient()来表示。如果想要表示发散性的颜色标度，可以使用scale_color_gradient2()函数，它可以使用正数和负数来表示不同的颜色。如果想要区分出位于平均值以上和以下的点，那么这个函数是非常合适的。

另一个可以选用的函数是由viridis包提供的scale_color_viridis()，它是对ColorBrewer分类标度的一种连续模拟


```R
df <-tibble(   
    x =rnorm(10000),   
    y =rnorm(10000) ) 
ggplot(df, aes(x, y)) +
    geom_hex() +
    coord_fixed() # 调纵横比，使其更美观

ggplot(df, aes(x, y)) +
    geom_hex() +  
    viridis::scale_fill_viridis() +
    coord_fixed()
```


![png](output_34_0.png)



![png](output_34_1.png)



```R
# 为什么以下代码没有覆盖默认标度？
ggplot(df, aes(x, y)) +
geom_hex() +
scale_color_gradient(low ="white", high ="red") +
coord_fixed()

# color设置的是边框，改为fill就覆盖了
ggplot(df, aes(x, y)) +
geom_hex() +
scale_fill_gradient(low ="white", high ="red") +
coord_fixed()
```


![png](output_35_0.png)



![png](output_35_1.png)



```R
# 修改presidential图形的显示
library(scales)
presidential %>%
    mutate(id =33+row_number()) %>%
    ggplot(aes(start, id, color = party)) +
        geom_point() +
        geom_segment(aes(xend = end, yend = id)) +
        labs(
            title = "American presidential and party",
            subtitle = "segment present administration time")+
#         geom_text(aes(label =  name))+# 加文本不如下面的函数
        geom_label(
            aes(label = name),
            nudge_y = 0.2,
            alpha = 0.5
        )+
#         scale_colour_manual(       
#             values =c(Republican ="red", Democratic ="blue")# 手动指定颜色
#         )# 手动指定颜色
# viridis::scale_fill_viridis() 
scale_color_brewer(palette = "Dark2")+
scale_x_date(breaks=date_breaks("4 years"),labels=date_format('%y'))+# library(scales)
# scale_x_date(
#     NULL,
#     breaks = presidential$start,
#     date_labels = "%y")+
scale_y_continuous(breaks = seq(33,45, by = 1))

```

    
    Attaching package: ‘scales’
    
    The following object is masked from ‘package:purrr’:
    
        discard
    
    The following object is masked from ‘package:readr’:
    
        col_factor
    



![png](output_36_1.png)


## 缩放


```R
ggplot(mpg, mapping =aes(displ, hwy)) +
geom_point(aes(color = class)) +
geom_smooth() +
coord_cartesian(xlim =c(5, 7), ylim =c(10, 30)) 
# 明显使用coord_cartesian()函数更好
mpg %>%filter(displ >=5, displ <=7, hwy >=10, hwy <=30) %>%# 调整绘图数据
ggplot(aes(displ, hwy)) +
geom_point(aes(color = class)) +geom_smooth()
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_38_1.png)



![png](output_38_2.png)



```R
suv <- mpg %>%filter(class =="suv") 
compact <- mpg %>%filter(class =="compact") 
ggplot(suv, aes(displ, hwy, color = drv)) +
    geom_point() 
ggplot(compact, aes(displ, hwy, color = drv)) +
    geom_point()
# 两幅图范围和颜色属性不一样
```


![png](output_39_0.png)



![png](output_39_1.png)



```R
# 使用全局标度
x_scale <-scale_x_continuous(limits =range(mpg$displ)) 
y_scale <-scale_y_continuous(limits =range(mpg$hwy))
col_scale <-scale_color_discrete(limits =unique(mpg$drv)) 
ggplot(suv, aes(displ, hwy, color = drv)) +
    geom_point() +  
    x_scale +  
    y_scale +  
    col_scale 

ggplot(compact, aes(displ, hwy, color = drv)) +
    geom_point() +  
    x_scale +  
    y_scale +  
    col_scale
```


![png](output_40_0.png)



![png](output_40_1.png)


## 主题


```R
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se =FALSE) +
#     theme_bw()#　可以试用不同的主题
    theme_classic()
# 定制主题需要花时间
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'



![png](output_42_1.png)



```R
# 保存图像
ggplot(mpg, aes(displ, hwy)) +geom_point()
ggsave("My-plot.pdf")
```

    Saving 6.67 x 6.67 in image



![png](output_43_1.png)

