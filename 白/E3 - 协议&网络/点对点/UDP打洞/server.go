package main
​
import (
    "fmt"
    "log"
    "net"
    "time"
)
​
func main() {
	// 开始监听UDP 端口 9999
	listener, err := net.ListenUDP("udp", &net.UDPAddr{IP: net.IPv4zero, Port: 9999})
	
	// 输出错误信息
    if err != nil {
        fmt.Println(err)
        return
	}
	// 记录
	log.Printf("本地地址: <%s> \n", listener.LocalAddr().String())
	
	// 生成 一个 netUDP 地址对象的 数组 ，长度为2
	peers := make([]net.UDPAddr, 0, 2)
	// 生成 一个 字符对象  数组 ，长度为 1024 ，1k
	data := make([]byte, 1024)
	
	// 业务循环
    for {
		// 从监听的UDP 中读取数据到 data ，并返回 请求地址，错误信息
		n, remoteAddr, err := listener.ReadFromUDP(data)
		
		// 错误信息不为空
        if err != nil {
            fmt.Printf("error during read: %s", err)
		}
		
		// 记录远程地址的字符串和网络数据
		log.Printf("<%s> %s\n", remoteAddr.String(), data[:n])
		
		// 在 peers 中添加 远程地址 ，并重新赋值到 peers
		peers = append(peers, *remoteAddr)
		
		// 当有俩个节点进入时
        if len(peers) == 2 {
			// 记录需要打洞的俩个地址和端口
			log.Printf("进行UDP打洞,建立 %s <--> %s 的连接\n", peers[0].String(), peers[1].String())
			//  开始打洞 发送数据到 对应的peers ，但返回另一个节点的地址
            listener.WriteToUDP([]byte(peers[1].String()), &peers[0])
			listener.WriteToUDP([]byte(peers[0].String()), &peers[1])
			// 休眠
			time.Sleep(time.Second * 8)
			//  退出服务器
            log.Println("中转服务器退出,仍不影响peers间通信")
            return
        }
    }
}