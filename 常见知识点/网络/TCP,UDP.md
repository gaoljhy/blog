# TCP

每个数据包都有序号,可多个并行发送

处理乱序和丢失数据包,可以根据拥挤情况自动调整传输速率

缺点 

确认包 太多,但无有用信息,对延迟较低的需求不太友好

# UDP

不提供数据重发和修复,无法得知是否收到,自我定制高

在线游戏或者在线直播选用较多

## 校验和 checksum

UDP 和 TCP 都有校验和,为传送包中01直接按十进制加起来的和

UDP 中为 16位 ,超出的高位扔掉,保留低位

## 模型

物理层,数据链路层,网络层,传输层,应用层

## 网络中立性

所有用户的数据包具有同等优先性,不是购买快速套餐决定,但有区分的是视频速度和文本速度有差异