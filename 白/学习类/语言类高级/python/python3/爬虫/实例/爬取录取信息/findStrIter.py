"""
查找页面内的指定内容
"""

import re

# re 类别名称
find1 =  r'none;">(.*?)</a></td>'

# re 子类别链接
find2 = r'<a href="[^\s]*'

# re 学校名称链接 (需要去掉detail.html, 取奇数位置)
find3 = r'<a href="[^\s]*\_detail.html'



# re 内容专业代号[4-1]  顺位+1
dai1 = r'class="report1_3_6">(.*?)</td>'    

# re 内容 专业名称[6-1] 偶数+2
dai2 = r'class="report1_3_1">(.*?)</td>'

# re 内容 计划数[1-1] 投档最低分[2-1]  已报人数[3-1] 学费[4-1] 间隔+4
dai3 = r'class="report1_4_3">(.*?)</td>'

# re 内容 办学地点[7-1] 偶数+2
dai4 = r'class="report1_3_1">(.*?)</td>'

# re 专业备注[0] 顺位+1
dai5 = r'class="report1_4_8">(.*?)</td>'


# re 子链接的内容一    本科二批 普通文科 354 上海海关学院报考情况
topic = r'class="report1_1_1">(.*?)</td>'

def findStr(pattern,content):
    ite = re.finditer(pattern,content)
    return ite

def findStrArr(pattern,content):
    pp = re.compile(pattern)
    ll = pp.findall(content)
    return ll