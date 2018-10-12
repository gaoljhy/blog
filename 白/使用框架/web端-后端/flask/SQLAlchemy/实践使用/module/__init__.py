from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


# 建立 基表 供派生
Base = declarative_base()

# 创建 engine 引擎
# 数据库必须已创建好
engine = create_engine('mysql+pymysql://root:root@localhost:3306/Pycharm', echo=True)

# 数据库中创建表
Base.metadata.create_all(engine)

# 创建操作对象
Session = sessionmaker(engine)

sess = Session()

