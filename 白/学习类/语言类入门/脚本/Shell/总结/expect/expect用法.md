# expect

例如：

自动登录脚本代码如下：  
  
    ```sh
    #!/usr/bin/expect  

    set timeout 30  

    spawn ssh -l username 192.168.1.1  

    expect "password:"  

    send "ispass\r"  

    interact  
    ```

## 解释

1. `#!/usr/bin/expect`
  
这一行告诉操作系统脚本里的代码使用那一个`shell`来执行。
 这里的expect其实和linux下的bash、windows下的cmd是一类东西。  

 > 注意：这一行需要在脚本的第一行。  
  
2. `set timeout 30`
  
基本上认识英文的都知道这是设置超时时间的，现在只要记住他的计时单位是：`秒`

3. `spawn ssh -l username 192.168.1.1`
  
spawn是进入expect环境后才可以执行的expect内部命令，如果没有装expect或者直接在默认的SHELL下执行是找不到spawn命令的。
所以不要用 `which spawn`之类的命令去找spawn命令。
好比windows里的dir就是一个内部命令，这个命令由shell自带，无法找到一个dir.com 或 dir.exe 的可执行文件。  

> 它主要的功能是给ssh运行进程加个壳，用来传递交互指令。  

4. `expect "password:"`


这里的`expect`也是`expect`的一个内部命令，有点晕吧，expect的shell命令和内部命令是一样的，但不是一个功能，习惯就好了。
这个命令的意思是判断上次输出结果里是否包含`“password:”`的字符串，如果有则立即返回，否则就等待一段时间后返回，这里等待时长就是前面设置的30秒  

5. `send "ispass\r"`
  
这里就是执行交互动作，与手工输入密码的动作等效。  

> 命令字符串结尾别忘记加上 `\r`，如果出现异常等待的状态可以核查一下。  

  `spawn`后 send 最后都追加一个回车符`\r`。因为这是程序之间的交互，用的是回车。

  但是没有spawn的情况下，send后面追加的是`\n`。这是方便输出到终端的操作。

6. `interact`  与 `interact` `expect eof`区别

1. 执行完成后保持交互状态，把控制权交给控制台，这个时候就可以手工操作了。
2. 如果没有这一句登录完成后会退出，而不是留在远程终端上。
3. 如果你只是登录过去执行一段命令就退出，可改为`expect eof`  

> https://www.cnblogs.com/lixigang/articles/4849527.html