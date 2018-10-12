## 用`Eclipse` 生成 `jar`包

### 第一：普通类导出jar包
>指此类包含main方法，并且没有用到别的jar包。 

1. 在eclipse中选择你要导出的类或者package，右击，选择Export子选项； 

2. 在弹出的对话框中，选择java文件---选择JAR file，单击next； 

3. 在JAR file后面的文本框中选择你要生成的jar包的位置以及名字
   
   注意在`Export generated class files and resources`和`Export java source files and resources`前面打上勾，单击next; 

4. 单击两次`next`按钮，到达`JAR Manifest Specification`。
   
   注意在最底下的`Main class`后面的文本框中选择你的`jar`包的入口类。单击Finish，完成。 

> 你可以在dos环境下，进入你的jar所在的目录，运行 java -jar 名字.jar，检测运行是否正确。 


----------------------

### 第二、导出的类里边用到了别的jar包。

> 比如说写的类连接了数据库，用到数据库驱动包oracl.jar.。 

1. 先把你要导出的类按照上面的步骤导出形成jar包，比如叫test.jar 

2. 新建一个文件夹main，比如在D盘根目录下； 

3. 把`test.jar`和`oracl.jar`拷贝到`main`文件下，右击`test.jar`，解压到当前文件夹。
   把`META-INF\MANIFEST.MF`剪切到另外一个地方 （比如是桌面！） ； 

4. 右击`oracl.jar`，解压到当前文件夹。 

5. 在`dos`环境下，进入到D盘的main文件夹下，执行 `jar cvfm new.jar meta-inf/manifest.mf .`，不要忘了最后面的点。 

6. 用压缩工具打开你新生成的`new.jar`，用你放在桌面的`META-INF\MANIFEST.MF`覆盖`new.jar`的`.MF`文件。 

> 你可以在dos环境下，进入你的jar所在的目录，运行 java -jar 名字.jar，检测运行是否正确。
