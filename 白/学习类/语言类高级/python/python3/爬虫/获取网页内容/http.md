```python
import http.client #导入包
 
conn = http.client.HTTPConnection("mlive.info") #连接到地址
 
conn.request("GET", "/index.html") #发送GET请求
 
r1 = conn.getresponse() #获取服务器的响应
 
print(r1.status,r1.reason) #打印服务器返回的状态
 
file = open("c:\\12.txt","w") #待开文件 写方式
 
str = r1.read().decode("utf-8") #读取网页内容,以utf-8方式保存
 
print(str.find("mlive")) #寻找文本
 
file.write(str.replace('\xa0','')) #写到文件并替换 'xa0' 为空字符.     如果不替换掉这个字符,将无法保存.   一个十分恶心的问题.
 
file.close() #关闭文件
 
```