import requests
import re
import time
import json
from requests.packages.urllib3.exceptions import InsecureRequestWarning
import pandas as pd
requests.packages.urllib3.disable_warnings(
    InsecureRequestWarning)  # ��ֹ����SSL����


class tb(object):

    def __init__(self, path, seach):  # ��������·��
        self.path = path  # ��������·��
        self.seach = seach  # ������
        self.s = requests.session()
        headers = {
            'Host': 's.m.taobao.com',
            'Accept-Encoding': 'br, gzip, deflate',
            'Connection': 'keep-alive',
            'Accept': 'application/json',
            'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36',
            'Accept-Language': 'zh-cn',
            'X-Requested-With': 'XMLHttpRequest',
        }
        self.s.headers.update(headers)  # ����ͷ��Ϣ

    def seachdata(self):
        for i in range(0, 100):
            time.sleep(1.25)
            url = 'https://s.taobao.com/search?q=%E7%A9%BA%E6%B0%94%E5%87%80%E5%8C%96&imgfile=&commend=all&ssid=s5-e&search_type=item&sourceId=tb.index&spm=a21bo.2017.201856-taobao-item.1&ie=utf8&initiative_id=tbindexz_20170306&fs=1&filter_tianmao=tmall'.format(
                self.seach, i)
            print(i)
            req = self.s.get(url=url, verify=False).text  # ��ȡҳ����
            try:
                js = json.loads(req)
                # print(js)
            except:
                print('err')
            listItem = js['itemsArray']
            # print(listItem)
            title = []  # ����
            sold = []  # ������
            commentCount = []  # ������
            item_id = []  # ��ƷID
            userId = []  # �̼�ID
            nick = []  # �̼�����
            location = []  # �̼ҵ�ַ
            pic_path = []  # ͼƬ
            itemNumId = []  # ��ƷNID
            originalPrice = []  # ԭ��
            price = []  # �ۼ�
            category = []  # ���ID
            itemurl = []  # ��Ʒ����
            if listItem == []:
                break

            for j in listItem:  # ������ȡ

                title.append(j['title'])
                sold.append(j['sold'])
                try:
                    commentCount.append(j['commentCount'])
                except:
                    commentCount.append('')
                item_id.append(j['item_id'])
                userId.append(j['userId'])
                # 商品名
                nick.append(j['nick'])
                # 链接
                location.append(j['location'])
                pic_path.append(j['pic_path'])
                # 销量
                itemNumId.append(j['category'])
                # 实际价格
                originalPrice.append(j['priceWap'])
                # 价格
                price.append(j['price'])
                try:
                    category.append(j['category'])
                except:
                    category.append('')
                itemurl.append(j['auctionURL'])
                data = {
                    'title_����': title,
                    'sold_������': sold,
                    'commentCount_������': commentCount,
                    'item_id_��ƷID': item_id,
                    'userId_�̼�ID': userId,
                    'nick_�̼�����': nick,
                    'location_�̼ҵ�ַ': location,
                    'pic_path_ͼƬ': pic_path,
                    'itemNumId_��ƷNID': itemNumId,
                    'originalPrice_ԭ��': originalPrice,
                    'price_�ۼ�': price,
                    'category_���ID': category,
                    'itemurl_��Ʒ����': itemurl,
                }

                df = pd.DataFrame(data)
                if i == 0:
                    df.to_csv(self.path+r'/shop.csv', index=False,
                              header=1, encoding="GB18030")
                else:
                    df.to_csv(self.path+r'/shop.csv', index=False,
                              header=0, mode='a', encoding="GB18030")  # �����ļ�


if __name__ == '__main__':
    t = tb(r'/Workspace', '�ֻ�')
    t.seachdata()
