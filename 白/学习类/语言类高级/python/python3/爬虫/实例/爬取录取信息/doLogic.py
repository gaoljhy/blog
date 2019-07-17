'''
1. 输入 类别 网址 
2. 得到子页面链接 和 类别名称
3. 进如子页面链接 得到学校名称链接
4. 进入学校名称链接
5. 得到内容保存到文件
'''
import getHtml as getH
import findStrIter as findS
import sys


def runAll():
    host = "http://www.nm.zsks.cn"
    url = str(input("input Http Url:"))
    filep = str(input("input file name:"))
    ht = getH.getContent(url)
    itr = findS.findStr(findS.find2, ht)
    for i in itr:
        lo = i.string[i.start()+9:i.end()-1]
        # print (lo)
        # 访问下一级页面
        pt = getH.getContent(host+lo)
        itrp = findS.findStr(findS.find3, pt)
        for x in itrp:
            po = x.string[x.start()+9:x.end()-12]+".html"
            # print(po)
            # 进入下一级页面
            gt = getH.getContent(host+po)
            # 进入最终页面
            l1 = findS.findStrArr(findS.dai1, gt)
            l2 = findS.findStrArr(findS.dai2, gt)
            l3 = findS.findStrArr(findS.dai3, gt)
            l4 = findS.findStrArr(findS.dai4, gt)
            l5 = findS.findStrArr(findS.dai5, gt)
            topc = findS.findStrArr(findS.topic, gt)
            for x in range(len(l5)):
                st = l1[4-1+x]+'\t'
                st += l2[6-1+(x*2)] + '\t'
                st += l3[1-1+(x*4)] + '\t'
                st += l3[2-1+(x*4)] + '\t'
                st += l3[3-1+(x*4)] + '\t'
                st += l3[4-1+(x*4)] + '\t'
                st += l4[7-1+(x*2)] + '\t'
                st += l5[1-1+x]+'\t'
                st += topc[0][:4]+'\t'
                st += topc[0][4:8]+'\t'
                st += topc[0][8:11]+'\t'
                st += topc[0][11:]+'\t'+'\n'
                # print(st)
                getH.saveTxt(st, filep)


if __name__ == "__main__":
    runAll()
