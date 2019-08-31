git初始化:git init

初始化之后可以设置 git config，方法是：

git config --global user.email "your email"

git config --global user.name "your name"

email和name在本地仓库可以随便写，--global可以换成local。

git status ：查看git状态

git add ： 加入文件或改变到工作空间

git commit -m "短的说明信息" ：提交到本地仓库

git log ：查看日志

git clone ：拉取远程仓库到本地，可以选择https或者ssh，能ping的通的话都可以，像是有些地方，github被屏蔽，
可以试试ssh是否可以。我不能通过https下载，通过ssh可以。方法是：

通过ssh命令产生公钥和私钥(参考ssh免密登录)，将公钥复制到github，

在github上点击setting，可以看到ssh and GPG keys，复制过去就可以
