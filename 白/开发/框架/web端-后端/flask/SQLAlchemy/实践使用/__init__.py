from flask import Flask

from tem.module import sess
from tem.module.module import temp


def tem():
    te = temp(name="hello")

    # 添加 add() add_all()
    sess.add(te)
    sess.add_all([te])

    # 这些函数得到都是对象，且包含的操作方法都是一样的
    # 所以可以多次 重复操作，叠加操作
    # query(t) 得到 t 对应的表单
    # filter(t.id >10) 挑选 t 中某一列符合判断语句的出来

    # 删除 delete() ,没有返回 0 ，warning
    sess.query(temp).filter(temp.id == 'hello').delete()

    # 修改 1.通过返回对象修改 2.通过uppdate()
    fir = sess.query(temp).filter(temp.name=="hello").first()
    fir.name = "new hello"

    # 该方法不需要 commit，直接变换
    # sess.query(temp).filter(temp.name=='new hello').update({temp.name:"hello"})

    # 查找
    # 返回结果为 temp 的内置函数 __repr__() 设定的内容
    sess.query(temp).filter(temp.name=="new hello").first()
    sess.query(temp).filter(temp.name == "new hello").all()
    sess.query(temp).all() # 返回数组

    sess.commit()


app = Flask(__name__)


@app.route('/')
def hello_world():
    tem()
    return 'Hello World!'
