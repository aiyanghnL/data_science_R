# 这是关于R安装和配置的记录文档
## jupyter安装R内核
[官方安装说明](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

下面说的是安装development版

以Debian系为例，首先安装依赖

```shell
sudo apt install libcurl4-openssl-dev libxml2-dev libssl-dev 

```



```R
# 首先安装devtools包
# 先安装RCurl包
install.packages("RCurl")
install.packages("devtools")
# 接着利用devtools从github安装IRkernel包，
devtools::install_github('IRkernel/IRkernel')
# 接着是
IRkernel::installspec()
# 如果出现错误应该是缺少依赖，按照提示安装

```
官方更详细的是:[点击链接](https://irkernel.github.io/installation/#devel-panel)

如果发现不能安装则直接安装二进制版：install.packages("IRkernel")


