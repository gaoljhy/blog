package main
​
import (
    "fmt"
    "log"
    "net"
    "os"
    "strconv"
    "strings"
    "time"
)
// ​ 进程标示
var tag string

// ​握手包信息
const HAND_SHAKE_MSG = "我是打洞消息"
const SERVER_ADDRESS = "3.3.3.1"
​
func main() {

    // 当前进程标记字符串,便于显示
	tag = os.Args[1]
	
	// 监听端口
	srcAddr := &net.UDPAddr{IP: net.IPv4zero, Port: 9999} // 注意端口必须固定

	// server 地址
	dstAddr := &net.UDPAddr{IP: net.ParseIP(SERVER_ADDRESS), Port: 9999}
	
	// 建立连接对象，返回连接对象和错误信息
	conn, err := net.DialUDP("udp", srcAddr, dstAddr)
	//  如果存在错误
    if err != nil {
        fmt.Println(err)
	}
	// 传输信息，验证是否错误
    if _, err = conn.Write([]byte("hello, I'm new peer:" + tag)); err != nil {
        log.Panic(err)
	}
	// 申请 一个存放字节流的data 数组
	data := make([]byte, 1024)
	
	//  从server端读取返回的另一个peer 的ip地址
    n, remoteAddr, err := conn.ReadFromUDP(data)
    if err != nil {
        fmt.Printf("error during read: %s", err)
    }
	conn.Close()
	
	// 获得另一个节点ip 和端口地址
	anotherPeer := parseAddr(string(data[:n]))
	// 输出 本地 ip , local ip + 服务器 serve ip + 另一个节点 地址
    fmt.Printf("local:%s server:%s another:%s\n", srcAddr, remoteAddr, anotherPeer.String())
​
    // 开始打洞
    bidirectionHole(srcAddr, &anotherPeer)
​
}
​
// 处理返回的data 中的ip 和端口数据 并转换为
func parseAddr(addr string) net.UDPAddr {
	// 以:分割 ip 和 port
	t := strings.Split(addr, ":")
	// 将 port string to  int
	port, _ := strconv.Atoi(t[1])
	//  产生 UDPAddr 对象
    return net.UDPAddr{
        IP:   net.ParseIP(t[0]),
        Port: port,
    }
}
​
//  打洞操作
func bidirectionHole(srcAddr *net.UDPAddr, anotherAddr *net.UDPAddr) {
	// 建立连接对象
	conn, err := net.DialUDP("udp", srcAddr, anotherAddr)
    if err != nil {
        fmt.Println(err)
	}
	//  延迟关闭，在对象释放以后 自动gc处理
    defer conn.Close()
	
	// 向另一个peer发送一条udp消息(对方peer的nat设备会丢弃该消息,非法来源),用意是在自身的nat设备打开一条可进入的通道,这样对方peer就可以发过来udp消息
    if _, err = conn.Write([]byte(HAND_SHAKE_MSG)); err != nil {
        log.Println("send handshake:", err)
	}
	// 满足俩个线程可以同时接收，也可以同时发送
	// 以并发的方式执行匿名函数func
	// 循环隔10s向对方发送信息
    go func() {
        for {
			time.Sleep(10 * time.Second)
			// 进程标示
            if _, err = conn.Write([]byte("from [" + tag + "]")); err != nil {
                log.Println("send msg fail", err)
            }
        }
	}()
	// 循环监听获取信息
    for {
		data := make([]byte, 1024)
		// 获取信息，并输出
        n, _, err := conn.ReadFromUDP(data)
        if err != nil {
            log.Printf("error during read: %s\n", err)
        } else {
            log.Printf("收到数据:%s\n", data[:n])
        }
    }
}