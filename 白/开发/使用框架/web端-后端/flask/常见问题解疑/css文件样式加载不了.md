1. 很可能是文件加载不正确

    `{{ url_for("static",filename="/css/bootstrap.min.css") }}`

    这个是不正确的

    `css/bootstrap.min.css`
    `css`前不应加 `/` ,自带一个`/`,会造成重复


2. 没清除缓存记录
    导致不能缓存东西 

3. 多应用中返回404
    blog = Blueprint("blogd",__name__)
    url_for("stati",filename="") 
    未指定 `blogd`
    应为  
    `blogd.static`
    蓝图名称(不是蓝图对象) ， 加 static or template

