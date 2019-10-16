##第四章也忒简洁了，就这么多代码，还是第三章的，还有就是建议我们使用R脚本和rstudio
library(dplyr) 
library(nycflights13)
not_cancelled <- flights %>%filter(!is.na(dep_delay), !is.na(arr_delay)) 
not_cancelled %>%group_by(year, month, day) %>%summarize(mean =mean(dep_delay))

## 上面的代码上一章已经说的很明白
## 完