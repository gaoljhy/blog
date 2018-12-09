Android Studio生成的APP默认图标是经典的机器人图标。可以通过Android Studio实现APP图标和名称的修改。

修改APP图标
========

在程序对应的`AndroidMenifest.xml`中指定了该APP的图标。

```xml
<application>
 
  ......
 
  android:icon="@mipmap/ic_launcher"
 
</application>
```

其中，`mipmap/ic_launcher`对应了`应用程序名/app/src/main/res`中的多个以`mipmap`开头的文件夹

hdpi、mdpi、xhdpi、xxhdpi和xxxhdpi的区别
----------------

以上五个文件夹对应了不同屏幕密度下使用的图标。
> 屏幕密度简称`DPI`，其全称为`Dots Per Inch`，表示“每英寸的像素点”，该值越大显示的图标则越清晰。

1. `ldpi`表示屏幕密度是`120`；
2. `mdpi`表示屏幕密度是`160`；
3. `hdpi`表示屏幕密度是`240`；
4. `xhdpi`表示屏幕密度是`320`；
5. `xxhdpi`表示屏幕密度是`480`；
6. `xxxhdpi`表示屏幕密度是`640`

>不同文件夹下，保存了不同屏幕密度的图标。

可以通过两种方式修改APP的图标，一种是修改图标资源；另一种是修改图标资源值
---------------------------

1. 通过修改图标资源实现图标的修改

    将APP的新图标名修改为`ic_launcher.png`
    之后将其拷贝到 `hdpi、mdpi、xhdpi、xxhdpi和xxxhdpi` 中5个文件夹中，覆盖之前的`ic_launcher.png`文件
    之后运行程序即可实现APP图标的修改。

2. 通过修改图标资源值实现图标的修改
    在`AndroidMenifest.xml`中的`android:icon`指定的是APP图标资源，可以将其修改为其它值。

    例如，将APP新图标拷贝到`drawable`文件夹下，并将`AndroidMenifest.xml`修改为

    ```xml
    <application>
    ......
    android:icon="@drawable/ic_launcher"
    </application>
    ```
    此时，运行程序也可以实现APP图标的修改。
