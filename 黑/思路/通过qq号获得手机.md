偶有奇想，我们可以通过手机号来搜索获取其对应的QQ号，那么，反过来呢？

一，缩小范围

由于手机号属于隐私数据，腾讯QQ并没有直接给出通过QQ号查找对应手机号的接口。

国内的手机号有十一位数字，从数学的角度上来说，包含了1011种可能。如果遍历这1011个数据，通过QQ中手机号查找QQ号的接口来寻找，未免太过费时费力，根据网上查到的资料，同一个QQ号，在十分钟内只能进行30次查询（未验证）。因此，直接遍历的方法不现实。

在这10^13个数据中，包含着大量的可去除的无用数据。我们很容易就能想到，去除无用数据，缩小范围。

1，通过“找回密码”

在所有需要密码的社交软件中，都会有处理用户遗忘密码情况的机制（通常为“找回密码”或“重置密码”），QQ也不例外。

通过搜索“QQ 找回密码”，很容易可以进到找回密码的页面，输入对应的QQ号，选择“验证密保找回密码”，得到如下弹窗：



通过密保手机找回密码

Bingo！

现在我们获取到了手机号十一位数字中的五位（前三位与后两位）！

2，通过号码归属地区

即便如此，现在依然有一百万种可能的情况，依然不适合遍历的方法。我们需要进一步缩小范围。

以什么为筛选条件呢？位置。

目前我国使用的手机号码为11位数字，我们的手机号可以分为三段，都有不同的编码含义：前3位是网络识别号、4-7位是地区编码（HLR归属位置寄存器）、8-11位是用户号码（随机分配）。

现在，我们已经得到了，手机号码的前三位代表了运营商，之后四位代表了地区。显然，我们可以通过遍历手机号中的4-7位，即一万个数据，以所属地区为筛选条件进一步缩小范围。

此处，我采用百度APIStore中的通过手机号查询归属地的API来进行查询，该API查询返回结果如下(测试了一个手机号，已略去)：

{"data":{"areacode":"0510","city":"无锡市","operator":"电信177卡","phone":"177******77","postcode":"214000","province":"江苏"},"error":0,"msg":"succeed"}

遍历代码如下(以查询所在地“上海”为例)：

public static void main(String[] args0) throws IOException {

FileWriter fileWriter = new FileWriter("/Users/huang/test/test1.txt");String httpUrl = "http://apis.baidu.com/chazhao/mobilesearch/phonesearch";String httpArg = "";for (int i = 0; i < 9999; i++) {if (i >= 1000) {

httpArg = "phone=178" + String.valueOf(i) + "0077";

} else if (i >= 100) {

httpArg = "phone=1780" + String.valueOf(i) + "0077";

} else if (i >= 10) {

httpArg = "phone=17800" + String.valueOf(i) + "0077";

} else {

httpArg = "phone=178000" + String.valueOf(i) + "0077";

}String jsonResult = request(httpUrl, httpArg);if (jsonResult.contains("上海")) {

fileWriter.write(httpArg + "\n\t");

}

}

fileWriter.flush();

fileWriter.close();

}/**

* @param urlAll

*            :请求接口

* @param httpArg

*            :参数

* @return 返回结果

*/public static String request(String httpUrl, String httpArg) {

BufferedReader reader = null;String result = null;

StringBuffer sbf = new StringBuffer();

httpUrl = httpUrl + "?" + httpArg;try {

URL url = new URL(httpUrl);

HttpURLConnection connection = (HttpURLConnection) url

.openConnection();

connection.setRequestMethod("GET");// 填入apikey到HTTP headerconnection.setRequestProperty("apikey", "您自己的apikey");

connection.connect();

InputStream is = connection.getInputStream();

reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));String strRead = null;while ((strRead = reader.readLine()) != null) {

sbf.append(strRead);

sbf.append("\r\n");

}

reader.close();

result = sbf.toString();

} catch (Exception e) {

e.printStackTrace();

}return result;

}

}

在我的查询中，4-7位共有36个可能，乘上第八位和第九位的一百种可能，我们已经把数据范围缩小到3600个！

二，生成通讯录并导入手机

3600个数据已经足够小，我们可以直接将其作为通讯录传入手机：
在Excel中填入36个手机号，并使其自动填充完3600个数据（首列为姓名）。



Excel填充的3600个数据

将其导出为.csv格式，我们可以利用QQ同步助手的导入联系人功能，将其导入至云端，之后通过手机端APP同步进手机。



csv文件作为通讯录导入资料库

在导入完成之后，我们便可以直接在好友列表下得到其对应的手机号（在已加为好友的状态下），或者通过通讯录添加好友的方式，在众多的新好友中找到对应的那一个，此时，其手机号便是所寻找的。



此时，手机号便是所寻找的

三、总结

通过QQ号查询绑定的手机，我们总共用到了两个信息以及一个前提，即QQ号和归属地，前提是QQ号绑定了手机。



Point.1 针对上文中提及的“缩小范围”

在上文中，我们通过QQ的“找回密码”功能确定了手机号的前三位以及后两位，并且，通过查找归属地的方法将4-7位控制在一个很小的范围。

现在，我们唯一不确定的只剩下第8、9位，那么是否有方法来进一步缩小范围呢？

答案是有的。

1.1 查找注册的网站

曾经，在网站REG007中，我们可以通过邮箱或手机号查找大部分以此为账号注册的网站，现在依然无法访问。

这类网站的原理，就是通过使用者输入的手机号或者邮箱去各大网站注册新用户，如果在网站中已经注册，它的返回值和未注册的用户返回值不相同，据此，可以区分手机号或邮箱是否在某个网站中注册。

同理，我们可以使用需要查找的QQ邮箱来作为账号在别的网站中测试“找回密码”功能，通过使用上文中提到的“找回你”等网站，我们可以获取该QQ邮箱注册过的网站。

1.2 在注册的网站中使用“找回密码”功能

笔者此次测试的是支付宝。

笔者发现仅需通过邮箱+图片验证就可以轻易进入到充值登录密码的界面，而这个页面包含的信息就是我们想要的。


支付宝重置登录密码界面

在上图中，我们可以看到其已经显示了绑定手机号的前三位+后四位。

根据这个方法，由于各个网站“找回密码”的机制不尽相同，我们可以将范围进一步缩小。

Point.2 针对上文中提及的“位置信息”

在上文中，我们在对手机号进行筛选时用到了一个关键的信息：位置。那么，位置信息又该从何处获取呢？笔者于此提供两种思路。

2.1 在社交账户中的“个人信息”

在我们仅有QQ号这一个条件的情况下，我们可以通过两种方式来查看，其一是个人资料的基本信息，其二是QQ空间中的“个人档”。


QQ-个人资料

2.2 发表的状态中定位及照片

我们大多都会注意到，在发表的状态中可能会包含着位置的信息，此处略表不提。

笔者需要说明的是，在图像文件中，并不仅仅包含着图片的像素信息，还有可能包含着Exif信息。

Exif是一种图像文件格式，它的数据存储与JPEG格式是完全相同的。实际上Exif格式就是在JPEG格式头部插入了数码照片的信息，包括拍摄时的光圈、快门、白平衡、ISO、焦距、日期时间等各种和拍摄条件以及相机品牌、型号、色彩编码、拍摄时录制的声音以及GPS全球定位系统数据、缩略图等。你可以利用任何可以查看JPEG文件的看图软件浏览Exif格式的照片，但并不是所有的图形程序都能处理Exif信息。

查看照片的Exif信息有许多工具，如PS等软件。


通过PS查看照片的位置信息

主要提供了一种进一步缩小范围的思路，以此为基础，我们可以在一小时之内就能确定与QQ号绑定的手机号。

补充：

非接触信息收集，顾名思义，就是在不物理接触目标的情况下，通过互联网或其他手段，对目标进行信息收集。主要包括以下信息：

姓名
性别
出生日期
身份证号码
身份证家庭住址
快递收货地址
地理位置 （照片EXIF提取;IP地址;附近的人三角定位，三角定位仅为思路）
学历/小初高大各学校 目标履历素描
QQ
手机号（曾用与现用）
邮箱
银行卡
电子邮箱
支付宝
各SNS主页 微博，人人网，百度贴吧，网易轻博客等
常用ID
目标性格素描
