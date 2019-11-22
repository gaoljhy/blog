
# 配置项

`sdtv_mode = 0` (預設是0 NTSC 但是大陸部分電視是PAL[歐規]就要改成 sdtv_mode =2 )
`sdtv_aspect = 3` ( 1 4:3, 2 14:9, 3 16:9 不要問我14:9是哪個怪比例....)
`hdmi_force_hotplug=1` (強制從hdmi輸出,根據博主測試,這個純粹是安心用...加不加無所謂)
`hdmi_drive=2` (這個很重要，如果是使用HDMI to DVI 要選擇 1[沒有聲音輸出] )
`hdmi_group=2` (1是 CEA，2是 DMT，這邊因為我要輸出到電視，所以選擇1。)
(這個是標準的選擇，差距在於兩個標準的輸出方式不同，CEA靠近電視，DMT比較靠近monitor,詳情參閱原文)
`hdmi_mode=35` (我們選擇了 1080P 60Hz，如果電視支援的比較少，請參考相對應的選擇...例如 720P)

参考以下

<http://blog.sina.cn/dpool/blog/s/blog_6ab7ecff0101afot.html>

https://blog.csdn.net/pang9998/article/details/90116371