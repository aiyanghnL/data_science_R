# 这是关于R安装和配置的记录文档
## jupyter安装R内核
[官方安装说明](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

下面说的是安装development版
```R
# 首先安装devtools包
install.packages("devtools")
# 接着利用devtools从github安装IRkernel包，
devtools::install_github('IRkernel/IRkernel')
# 接着是
IRkernel::installspec()
# 如果出现错误应该是缺少依赖，按照提示安装

```
官方更详细的是:[点击链接](https://irkernel.github.io/installation/#devel-panel)


