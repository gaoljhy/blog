```python
from flask import send_file
# 回传图片处理
@blog.route("/images/tm-bg-slide-<int:num>.jpg")
def jpg1(num):
    # print(num)
    filp = "static/images/tm-bg-slide-%s.jpg" % (num)
    return send_file(filename_or_fp=filp, mimetype="image/jpeg")
```