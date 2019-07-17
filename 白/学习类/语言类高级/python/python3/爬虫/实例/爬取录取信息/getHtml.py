"""
获取 指定 网页内容
"""

import urllib.request

headers = {"User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0", "character":"utf-8"}

opener = urllib.request.build_opener()

opener.addheaders = [headers]


def getContent(url):
    html = opener.open(url).read()
    # print(html.decode("utf-8"))
    return html.decode("gbk")

def saveTxt(strd,fileP):
    file = open(fileP,"a+")
    file.write(strd)
    file.close()