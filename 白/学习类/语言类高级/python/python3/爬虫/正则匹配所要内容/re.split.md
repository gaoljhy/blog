`split` 方法按照能够匹配的子串将`原字符串`分割后返回列表

`re.split(pattern, string[, maxsplit=0, flags=0])`

`pattern`	匹配的正则表达式
`string`	要匹配的字符串。
`maxsplit`	分隔次数，maxsplit=1 分隔一次，默认为 0，不限制次数。
`flags` 	标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。参见：正则表达式修饰符 - 可选标志



```python
>>>import re
>>> re.split('\W+', 'gao, gao, gao.')
['gao', 'gao', 'gao', '']

>>> re.split('(\W+)', ' gao, gao, gao.') 
['', ' ', 'gao', ', ', 'gao', ', ', 'gao', '.', '']

>>> re.split('\W+', ' gao, gao, gao.', 1) 
['', 'gao, gao, gao.']
 
>>> re.split('a*', 'hello world')   # 对于一个找不到匹配的字符串而言，split 不会对其作出分割
['hello world']
```