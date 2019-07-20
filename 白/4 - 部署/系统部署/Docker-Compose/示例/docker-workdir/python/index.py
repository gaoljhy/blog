import redis

# #创建连接池
# pool = redis.ConnectionPool(host='myredis',port=6379,decode_responses=True)

# #使用原生redis 创建链接对象
# r=redis.Redis(connection_pool=pool)

# r.set("name")

r = redis.Redis(host='myredis', port=6379, db=0,decode_responses=True)

r.set("name","gao")
r.get("name")

while True:
    pass