js修改标签属性
============

1. 获取标签
    1. document.getElementById( id )
    2. document.getElementsByName( name )
    3. document.getElementsByTagName( tagname ) 直接访问标签
2. 修改属性
    1. DOM对象.属性名 = 值;

实例

```js
    var d = document.getElementById('d');
    //字体颜色
    d.style.color = '#f00';
    //字体加粗
    d.style.cssText += 'font-weight:bold';
    d.style.cssText += 'font-size:19px';
    //添加类名
    d.className = 'a';
    d.className += ' b';

```