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


## 使用rpy2包在R-py之间切换：

先安装rpy2: pip install rpy2

导入rpy2, 新版 ryp2 已改成: %load_ext rpy2.ipython

将整个cell设为R代码：%%R

%%R

A <- matrix(1, 15, 15) A[4,7] <- 0 persp(A, expand=0.5)

将一行设为R代码： %R

%R print("Hi from R")

从R获取变量var：%R -o var

从Python获取变量var: %R -i var

references:

[1](http://news.hiapk.com/internet/s593427f2c668.html)

[2](http://nbviewer.jupyter.org/github/yenlung/Computing-Life-with-Computers/blob/master/Topic_R%20in%20IPython.ipynb#)

这样比仅仅在notebook使用一种语言有优势