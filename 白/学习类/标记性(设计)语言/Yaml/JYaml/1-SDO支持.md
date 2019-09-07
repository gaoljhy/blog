# YAML和SDO（只讨论双方的java实现）

更多SDO的概念， 请参见<http://www.ibm.com/developerworks/library/specification/j-commonj-sdowmt/index.html>

> 这里只讨论`SDO`的`java`实现。

SDO里有一个很重要的概念，`DataObject`。

从`DataObject`的接口里，可以看出有两类的数据类型

1. 一类是`JYaml`支持的，诸如`String, List`之类
2. 一类是DataObject

因此只需要增加一种支持`DataObject`的类型，就可以完成对`SDO DataObject`的支持。

## 实例

不妨叫`YamlDataObject`

### 下面是它的数据结构

```java
public class YamlDataObject {
    private String uRI;
    private String name;
    private Map attributes;
}
```

`YamlDataObject`里用到的类型，都是`JYaml`能够支持的。

其中，`uRI`和`name`用来描述`DataObject`自身。
`attributes`来描述`DataObject`里的值。
这些值可能为`DataObject`，也可能是`JYaml`所支持的其他类型。

希望用`YamlDataObject`来担当`DataObject`的角色，因此`YamlDataObject`和`DataObject`要能互相转化。

### 增加两个API

```java
private static YamlDataObject newInstance(DataObject dataobject){...
private DataObject toDataObject() {...
```

上面两个之所以是`private`的，是因为打算遵照`JYaml`的习惯，增加两个接口，`dump`和`load`，这样`newInstance`和`toDataObject`只在内部使用了。

### dump和load的定义：

```java
public static void dump(DataObject dataobject, File dumpfile) 
                  throws FileNotFoundException{...
public static Object load(File file) 
                  throws FileNotFoundException{...
```

### 测试代码

```java
// ... create dataobject ...
File bodump=new File("bodump.yaml");
YamlDataObject.dump(dataobject,bodump);
assertTrue(bodump.exists());
DataObject dataobject2 = (DataObject) YamlDataObject.load(bodump);

 // check result
assertNotNull(dataobject2);
for(int i=0; i<5; i++){
   assertEquals(dataobject.get(i),dataobject2.get(i));
}
```
