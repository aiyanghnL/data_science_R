# 一般写脚本添加#!开头的一行指定程序路径
#!/usr/bin/Rscript
library(tidyverse)
# 需要安装hexbin包
# 如果使用conda虚拟环境里的R，
# 安装需要编译的R包需要启动虚拟环境安装，一般是linux上安装某些包需要编译
# 不需要编译的包应该没问题
ggplot(diamonds, aes(carat, price)) +
  geom_hex()
ggsave("diamonds.pdf")
write.csv(diamonds, "diamonds.csv")
# 这里作者写的是write_csv()

