#!/usr/bin/python

import urllib
import urllib2

url = 'http://login.imau.edu.cn:801/srun_portal_phone.php?ac_id=1&url=http://www.itellyou.cn/'
data = "action=login&ac_id=1&user_ip=&nas_ip=&user_mac=&username=20&password=04HYY"
headers = {'Host': 'login.imau.edu.cn:801',
           'Cache-Control': 'max-age=0',
           'Origin':'http://login.imau.edu.cn:801',
           'Accept': 'text/html, */*; q=0.8',
           'X-Requested-With': 'XMLHttpRequest',
           'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36',
           'Referer': 'http://login.imau.edu.cn:801/srun_portal_phone.php?ac_id=1&url=http://www.itellyou.cn/',
           'Accept-Encoding': 'gzip, deflate, sdch',
           'Accept-Language': 'zh-CN,zh;q=0.8,ja;q=0.6',
           'Cookie': 'login=bQ0o5ZADI11BgO3HLndd%252Bxt3LbV4WDOtcUYRpEMiJNrQLR1ahypwMnoStwB6zmH%252FjsdSddAOOT%252FQyOtIDwWL%252BKsHG6davY3Z8VSM1H4iV99KThcQuVFn67RZJvUyKoBdLEM9%252B7751jJlA%252BV8A0l2%252Fdgl2Ax9A2FVL02brEE%253D'
           }
req = urllib2.Request(url, data, headers)
response = urllib2.urlopen(req)
html = response.read()
print html
