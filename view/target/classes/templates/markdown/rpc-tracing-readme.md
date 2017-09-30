## 查看调用链步骤
STEP1. 首先启动[Demo2](http://localhost:8082/demo2)；
STEP2. 点击“调用RpcApi”；
STEP3. 在新窗口中打开[http://localhost:9411/](http://localhost:9411/)查看调用链：
![zipkintrace](img/zipkintrace.png)

参考资料：
1. [zipkin.io](http://zipkin.io/)
2. [分布式跟踪系统（一）：Zipkin的背景和设计](http://blog.csdn.net/manzhizhen/article/details/52811600)
3. [分布式跟踪系统（二）：Zipkin的Span模型](http://blog.csdn.net/manzhizhen/article/details/53865368)
4. [部署Zipkin分布式性能追踪日志系统的操作记录](http://www.cnblogs.com/kevingrace/p/5570258.html)