# DS_Store

`.DS_Store`是Mac OS保存文件夹的自定义属性的隐藏文件，如文件的图标位置或背景色，相当于Windows的`desktop.ini`

## 禁止.DS_store生成

打开 “终端” ，复制黏贴下面的命令，回车执行，重启Mac即可生效。

`defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool FALSE`

## 恢复.DS_store生成

`defaults delete com.apple.desktopservices DSDontWriteNetworkStores`
