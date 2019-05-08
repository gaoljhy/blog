
import os
import sys

# 遍历指定目录，显示目录下的所有文件名
def eachFile(filepath , exp):
    pathDir =  os.listdir(filepath)
    father = []
    for allDir in pathDir:
        child = os.path.join('%s%s' % (filepath, allDir))
        if child.find(exp) != -1:
            # print(child.find(exp))
            father.append(child)
    return father

def eachFind(fil,strword):
    file=fil
    f = open(file, 'rb')
    lines = f.readlines()
    allf = []
    alls = []
    inum = 0
    for line in lines:
        inum += 1
        line = line.decode('utf8')
        jup = line.find(strword)
        if jup != -1:
            sd = str(inum)
            allf.append(sd)
            # print(line)
            alls.append(line)

    return allf,alls
    #     # print (line)
def printList(llp,plf ):
    scp = ""
    for i in range(len(llp)):
        scp += llp[i] + '\n'
        scp += plf[i] + '\n' + '\n'
    return scp

if __name__ == "__main__": 
    stt = sys.argv[1]
    sp = "//"
    # fl =  open("temp.txt","rw")
    for ip in eachFile("./","csv"):
        pfl,asl = eachFind(ip,stt)
        alle = ip+":\n" + printList(pfl,asl)+sp*20
        print(alle)
        # fl.write(alle)
    # fl.close()