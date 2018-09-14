
## `url_for`操作对象是函数，而不是`route`里的路径。

`url_for('login', next='/jhg')`
可以给 `@app.route('/log<next>') def login():`
调用并传参

`url_for('.static',_external=True,filename='pic/test.png')`
> 返回的url是`http://localhost/static/pic/test.png`







------------------
## `url_for()`函数参数

`endpoint `
> URL的端点（即函数的名字）

`values` 
> URL的 **变量参数**

`_external `
> 如果设置为`True`，则生成一个绝对路径URL

`_method `
> 如果设置这个则显示地调用这个HTTP方法
