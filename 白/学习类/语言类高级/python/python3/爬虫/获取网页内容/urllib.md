```python
import urllib.request

headers = {"User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0", "character":"utf-8"}

opener = urllib.request.build_opener()

opener.addheaders = [headers]

html = opener.open("http://www.nm.zsks.cn/zy_4_1_2015/kl_1.html").read()

print(html.decode("utf-8"))
```