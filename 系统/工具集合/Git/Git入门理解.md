# Git 入门

## 首先需要了解 git 的基本运行机制

![运行图]()

## 名称

+ 名称

Workspace ： 工作区

Index ： 暂存区

Repository ： 仓库区 （本地仓库）

Remote ： 远程仓库区 （GitHub仓库）

> 本地仓库 和 远程仓库 都包含整个项目的源代码，但是存在不同
> 本地仓库存在自己的修改，需要`push`通过以后才能内更新到y远程仓库区

---

## 基本流程如下

1. `git clone project_url` : 将远程服务器的项目克隆到本地(区分`fetch`刷新)
    >默认 是只下载 master 分支到本地
2. `git branch -a` : 查看本地和远程所有分支及关系
3. `git checkout mybranch` : 切换到固定分支,并更新工作区到固定分支
4. 本地增加、修改、删除文件
5. `git add file_name` 或 `git add .` : 将所有 或 固定有修改的文件保存至暂存区）
6. `git commit -m "your_commit_message"` : 提交至本地版本库
7. `$ git config [--global] user.name "[name]"`
    `$ git config [--global] user.email "[email addres]"` 设置你的用户名 和邮箱地址
8. `git push [remote-address] [branch]`# 上传本地指定分支到远程仓库
9. 输入你账户名和密码，完成

`git push [remote-address] [本地branch]:[远程branch]`

### 例子

--------------

> `git push origin back:blog` 推送本地的分支back到远程blog分支下

```sh
$ mkdir gao-git-test                     # 创建测试目录
$ cd gao-git-test/                       # 进入测试目录
$ echo "# Mr.G Git 测试" >> README.md     # 创建 README.md 文件并写入内容
$ ls                                        # 查看目录下的文件
README
$ git init                                  # 初始化
$ git add README.md                         # 添加文件
$ git commit -m "添加 README.md 文件"        # 提交并备注信息
[master (root-commit) 0205aab] 添加 README.md 文件
 1 file changed, 1 insertion(+)
 create mode 100644 README.md

# 提交到 Github 这里用ssh 
$ git remote add origin git@github.com:tianqixin/gao-git-test.git
$ git push -u origin master
```

---;

## 常见使用命令记录

1. 查看本地工作区与暂存区不同 `git diff`
2. 查看变动 `git status`
3. 取消一个 commit文件 `git reset HEAD -- [file]`

---

1. 更新远程仓库区变动 `git fetch`
2. 取回远程仓库的变化，并与本地工作区分支合并 `git pull [remote] [branch]`
3. 本地仓库提交以后，会使远程仓库和本地同步，所以远程仓库中多余的都会被删掉
