Hibernate 属性
============

全局配置属性
----------

| 属性                              | 描述                                                    |
| --------------------------------- | ------------------------------------------------------- |
| hibernate.dialect                 | 这个属性使 Hibernate 应用为被选择的数据库生成适当的 SQL |
| hibernate.connection.driver_class | JDBC 驱动程序类                                         |
| hibernate.connection.url          | 数据库实例的 JDBC URL                                   |
| hibernate.connection.username     | 数据库用户名                                            |
| hibernate.connection.password     | 数据库密码                                              |
| hibernate.connection.pool_size    | 限制在 Hibernate 应用数据库连接池中连接的数量           |
| hibernate.connection.autocommit   | 允许在 JDBC 连接中使用自动提交模式                      |

如果正在使用 JNDI 和数据库应用程序服务器然后必须配置以下属性
-------------

| 属性                              | 描述                                                                  |
| --------------------------------- | --------------------------------------------------------------------- |
| hibernate.connection.datasource   | 在应用程序服务器环境中您正在使用的应用程序 JNDI 名                    |
| hibernate.jndi.class              | JNDI 的 InitialContext 类                                             |
| hibernate.jndi.<JNDIpropertyname> | 在 JNDI的 InitialContext 类中通过任何你想要的 Java 命名和目录接口属性 |
| hibernate.jndi.url                | 为 JNDI 提供 URL                                                      |
| hibernate.connection.username     | 数据库用户名                                                          |
| hibernate.connection.password     | 数据库密码                                                            |
