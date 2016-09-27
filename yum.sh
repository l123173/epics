#!/bin/bash
# 配置yum源
web_yum=http://mirrors.163.com/.help/CentOS6-Base-163.repo #下载6，7有点问题
cd /etc/yum.repos.d/
for i in *
do
    mv $i $i.backup
done

wget $web_yum
sed -i 's/$releasever/6/g' CentOS6-Base-163.repo
yum clean all
yum makecache
