Command drvAsynIPPortConfigure not found.
在Makefile 里面加上 drvAsynIPPort.dbd  ，位置就在Sup 或者App里

P，T 等macro的赋值有几个地方可以，
至少这种方式是可以的！（st。cmd）
epicsEnvSet "P" "$(P=P)"
epicsEnvSet "R" "$(R=T)"


TOP 里db的文件是不容修改的，修改方式是修改Sup里的，然后make，自然改动


https://epics.anl.gov/tech-talk/2016/msg01418.php

If you want your asynTrace output to be in hex then you should change this line:
asynSetTraceIOMask("TMP_70kV",-1,0x2)  这个是8进制显示，在stcmd的显示界面
to this asynSetTraceIOMask("TMP_70kV",-1,0x4)  
