## `re.findall`
在字符串中找到正则表达式所匹配的所有子串，并返回一个`列表`，如果没有找到匹配的，则返回`空列表`。

>注意： `match` 和 `search` 是匹配一次, `findall` 匹配所有。

语法格式为：

`findall(string[, pos[, endpos]])`
参数：

`string` 待匹配的字符串。
`pos` 可选参数，指定字符串的起始位置，默认为 0。
`endpos` 可选参数，指定字符串的结束位置，默认为字符串的长度。


>  `re.complie()` 可自动只留下正则表达式部分


----------------
查找字符串中的所有数字：

实例
```python
import re
 
pattern = re.compile(r'\d+')   # 查找数字
result1 = pattern.findall('gao 123 google 456')
result2 = pattern.findall('run88oob123google456', 0, 10)
 
print(result1)
print(result2)
```




-----------------

`re.finditer`
和 `findall` 类似，在字符串中找到正则表达式所匹配的所有子串，并把它们作为一个`迭代器`返回。

`re.finditer(pattern, string, flags=0)`


`pattern`	匹配的正则表达式
`string`	要匹配的字符串。
`flags` 	标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。参见：正则表达式修饰符 - 可选标志


实例
```python
import re
 
it = re.finditer(r"\d+","12a32bc43jf3") 
for match in it: 
    print (match.group() )
```
