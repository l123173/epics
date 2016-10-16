说明：只是一个初版本的安装说明，如果有遇到什么没有涉及的问题，可以联系作者予以解决，改进；

以下内容均在脚本bash.sh中体现，可以直接运行脚本安装，节省时间。 自动安装，运行脚本方法（适用于centos，redhat，fedora等版本）：

配置好网络 切换到root权限 sh bash.sh 即可 所需要的基本知识：

1.解压缩命令 如解压缩base-3.15.2.tar.gz文件到/usr/目录下 tar zxvf base-3.15.2.tar.gz –C /usr/ 或者鼠标右键，剪切，extract here就行
2.查看、修改文件命令 如：打开123.txt gedit 123.txt
3.安装命令 yum install readline-devel（运行一下此命令，如出现报错，可能需配置yum源，运行脚本文件yum.sh,或者手动修改yum源）
配置yum源：

http://mirrors.163.com/.help/ 网站有很好的介绍，跟着操作即可，根据系统进入相关链接 需要安装的软件

Base http://www.aps.anl.gov/epics/base/index.php 建议下载3.15.2 不要使用3。14。12。1 太多问题了，太老

extensions http://www.aps.anl.gov/epics/extensions/index.php 建议下载Extensions build configure files (R3.14)
CSS http://cs-studio.sourceforge.net/
synApp https://www1.aps.anl.gov/BCDA/synApps/Where-to-find-it
目录结构

（仅是一个存放结构的参考，了解即可）

epics/
    base/
        Makefile
        configure/
    extensions/
        Makefile
        configure/
        src/
            Makefile
            extension1/
            extension2/
            ...
Extensions 根据使用需要下载，目前只需下载msi，解压缩msi到src目录下，修改Marefile文件，在MSI所在行后面添加对应的版本号，如1-7

make 编译通过即可 base and extensions安装

网上及解压缩文件内有install information，可以参考。 自动安装可以运行bash.sh脚本。 建议安装到opt 或者 usr文件夹下

######安装过程：

解压缩软件
按照目录结构，解压缩base，解压缩extensionsf

安装各种软件，re2c，设置yum源（看情况）  [此部分见后面]
base 直接make，应该不会有问题。

extensions/configure/目录下编辑RELEASE文件，修改EPICS_BASE和EPICS_EXTENSIONS 的值为正确路径（可使用vi或者gedit命令，参照所需要的基本知识部分）

现在是修改的etc/bashrc文件(可为每一个bash生效)
修改~/.bash_profile文件添加环境变量 EPICS_HOST_ARCH=linux-x86_64(32位系统输入linux-x86)，EPICS_BASE，EPICS_EXTENSIONS为相应的目录
vi ～/.bash_profile

安装msi到 extensions（下载地址见之前部分）
下载msi,解压缩到extensions src目录 修改Makefile文件，在MSI所在行后面添加对应的版本号，如1-7 make 无报错即可

安装synapps
手动修改信息（见后面论述）。自动的参考这个命令
sed -i "s/EPICS_BASE=\/home\/oxygen\/MOONEY\/epics\/bazaar\/base-3.15/EPICS_BASE=\/opt\/base/g" `grep EPICS_BASE=/home/oxygen/MOONEY/epics/bazaar/base-3.15 -rl /opt/synApps_5_8/support/`




进入re2c官网，Download部分下载re2c（版本随意）， ./configure Make Make install 安装完成 修改文件信息
安装如下软件包（含命令）
以下命令适用于类redhat操作系统，如redhat,Fedora,Centos
yum install perl libXt-devel libtermcap-devel libXp-devel flex yum install g++ autoconf automake readline-devel yum install gcc-c++ giflib-devel libXtst-devel yum install libX* yum install perl-ExtUt* openmotif-devel yum install perl-Pod-Checker yum install xorg-x11-xbitmaps yum install libmotif-devel libmu-devel X11proto-print-devel 编译

准备工作结束以后 在/base目录下make，等待结束，没有报错即是成功，或者base目录中出现bin文件，即为成功； 在/extensions 目录下make，没有报错即extensions安装成功 或者extensions目录下出现bin文件。 CSS 安装

直接下载安装(双击即可) http://cs-studio.sourceforge.net/ 需要更新java版本 SynApps 安装


synapps下所有模块的RELEASE文件

修改EPICS_BASE，Extension和SUPPORT的目录位置（很多个文件）
修改出现的版本信息编号错误（根据make返回信息）
5_8 需要修改caputRecorder（替换掉）
Make 不报错即可

caputRecorder.o 错误，去网上下在caputecorder-master，替换其中的caputRecorderApp文件，不要全部替换。

配置areaDecteror 文件,里头有说明文件，照着作 当然还有错误需要修改配置文件

Error napi.o do as instruction 注意local.x86_64 注意这个 64

tiff 安装，不要指定位置，自动安装 libjpeg http://www.ijg.org/files/ libxml2 安装(dnf ) 戴上-devel就可以了，不带不行）

Done

有任何发现的错误和问题，可以联系liangyx@ihep.ac.cn解决。

梁雅翔 2016.5.27
