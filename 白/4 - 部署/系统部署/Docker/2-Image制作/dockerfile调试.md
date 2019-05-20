# 调试

## debug Dockerfile

在写 Dockerfile 的时候，通常并不会一气呵成。
有的时候容器启动就crash 直接退出，有的时候build image 就会失败，或者想验证Dockerfile是否符合预期，经常要debug Dockerfile。

如果build 失败可以直接 查看`stdout`的错误信息，拆分指令，重新build。

## 但是一般调试方法是

选择失败的上一条continer 的 id ，进行`docker run -it`接入，测试

## logs 查看 stdout

所有容器内写到`stdout`的内容都会被捕获到`host`中的一个history文件中, 可以通过 `docker logs CONTAINER` 查看

