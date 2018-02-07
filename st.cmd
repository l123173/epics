Command drvAsynIPPortConfigure not found.
在Makefile 里面加上 drvAsynIPPort.dbd  ，位置就在Sup 或者App里

P，T 等macro的赋值有几个地方可以，
至少这种方式是可以的！（st。cmd）
epicsEnvSet "P" "$(P=P)"
epicsEnvSet "R" "$(R=T)"


TOP 里db的文件是不容修改的，修改方式是修改Sup里的，然后make，自然改动
