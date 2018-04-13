#!/bin/bash
# ------------------------------------------------------------------------------
# Filename:    base1.0.sh
# Revision:    1.0
# Date:        2016/05/14
# Author:      Liangyaxiang
# Email:       liangyx@ihep.ac.cn
# Description: It should be used in like-redhat system.
# Notes:       startup it with root

#set -e


#is it root?
if [ $UID -eq 0 ];then
    echo -e "\033[31m these will take a few minutes, if any question, let me know lianyx@ihep.ac.cn. \033[0m"
else
    echo -e "\033[31m Usage: execute Script with root \033[0m"
    sleep 2
    exit 
fi

sleep 2

echo -e "\033[31m *****************  begin  ********************* \033[0m"
sleep 2

#变量
file=/configure/os/CONFIG_SITE.Common.linux-x86_64
web_ba=https://www.aps.anl.gov/epics/download/base/baseR3.14.12.1.tar.gz
#web_ba=https://www.aps.anl.gov/epics/download/base/baseR3.14.12.5.tar.gz
#web_ba=http://www.aps.anl.gov/epics/download/base/base-3.15.3.tar.gz
web_ex=http://www.aps.anl.gov/epics/download/extensions/extensionsTop_20120904.tar.gz
web_re2c=https://github.com/skvadrik/re2c/releases/download/0.13.6/re2c-0.13.6.tar.gz
now_pwd=$PWD
Dir=/opt/epics
var='COMMANDLINE_LIBRARY = READLINE'

change_yum()  # change the yum
{
web_yum=http://mirrors.163.com/.help/CentOS6-Base-163.repo
cd /etc/yum.repos.d/
for i in *
do
    mv $i $i.backup
done

wget $web_yum
sed -ie 's/$releasever/6/g' CentOS6-Base-163.repo
yum clean all
yum makecache
}

function uncompress(){  # 解压缩文件
    mkdir -p $Dir/base $Dir/extensions #mkdir first; if not error
    tar zxvf base.tar.gz -C $Dir/base --strip-components 1  # /opt/epics/base/configure/
    tar zxvf extensions.tar.gz -C $Dir/extensions --strip-components 1 
    /bin/rm base.tar.gz extensions.tar.gz
}

conf()    #配置相关信息
{
  
    if [ -w $Dir/base$file ];then  #file=/configure/os/CONFIG_SITE.Common.linux-x86_64
      sed -i "s/$var/#$var/" $Dir/base$file #have the address, no need to change dir
      #var='COMMANDLINE_LIBRARY = READLINE'
    else
      chmod +w $Dir/base$file
    sed -i "s/$var/#$var/" $Dir/base$file
    fi

    sed -i "s/EPICS_BASE=\$(TOP)\/..\/base/EPICS_BASE=\/base/" $Dir/extensions/src
    sed -i "s/EPICS_EXTENSIONS=$(TOP)/EPICS_EXTENSIONS=$Dir/extensions" $Dir/extensions

    sed -i "/# User specific environment and startup programs/a\EPICS_HOST_ARCH=`$Dir/base/startup/EpicsHostArch.pl`\nEPICS_BASE=$Dir/base \nEPICS_EXTENSIONS=$Dir/extensions" ~/.bash_profile    

}

com() #compile it
{
    cd $Dir/base;	
    make;

    if [ $? -eq 0 ];
      then 
      echo -e "\033[32m base compile success \033[0m"
    else
      echo -e "\033 [32m base compile failed, you could contact liangyx@ihep.ac.cn \033[0m"
      exit
    fi

    cd $Dir/extensions;
    make && echo -e "\033[32m extensions compile success\033[0m" || echo -e "\033[32m extensions compile failed \033[0m"
}

re2c() # install re2c for synapp
{

local re2c_file=/usr/local/
wget -O re2c.tar.gz $web_re2c
#mkdir -p $re2c_file
tar zxvf re2c.tar.gz
cd re2c-0.13.6   #change name lager
./configure --prefix=$re2c_file
make && make install || echo -e "\033[32m make fail \033[0m"
/usr/bin/rm -rf re2c-0.13.6  #change name lager
/usr/bin/rm -rf re2c.tar.gz

}

##########
if [ -s $Dir/base ];then
    echo "exist"        #只是为了避免再执行的时候重复解压缩
else
    wget -O base.tar.gz $web_ba
    wget -O extensions.tar.gz $web_ex #change the name
    uncompress | tee -a ~/untar_information
fi


# 安装缺失的文件
yum -y install xorg-x11-xbitmaps libXt-devel libtermcap-devel libXp-devel xz-devel flex autoconf automake giflib giflib-devel libXtst-devel libX* gcc-c++ perl-ExtUt* perl-Pod-Checker readline-devel
#|tee -a ~/install_information.txt

yum install libXt-devel     error:miss X11.h
yum install openmotif-devel   or openmotif  or openmotif-dev     error: miss Xm.h    this was happen in centos

#执行
re2c
change_yum
conf |tee -a ~/configure_information
com |tee -a ~/compile_information
echo -e "\033[32m base and extension was installed in $Dir \033[0m"
