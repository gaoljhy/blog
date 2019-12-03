# 1 获取App的Bundle Identifier

Bundle Identifier是应用软件的标识，以Microsoft Word为例，Terminal中输入命令：

`mdls -name kMDItemCFBundleIdentifier /Applications/Microsoft\ Word.app`

得到结果：

`kMDItemCFBundleIdentifier = "com.microsoft.Word"`

# 2 修改应用程序默认语言

该操作需要用到第一步查到的应用程序Bundle Identifier，本例中是com.microsoft.Word，Terminal中输入命令：

`defaults write com.microsoft.Word AppleLanguages '("zh_CN")'`

    1

## 3 常用语言设置选项

第二步操作中用到了zh_CN，代表了简体中文，其他常用的语言项如下：

`en = English (US) `