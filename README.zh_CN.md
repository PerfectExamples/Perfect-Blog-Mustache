# Perfect Blog 以及 Mustache 模板使用示例 [English](README.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

基于 Perfect 的 Blog 搭建和 Mustache 模板使用示例

本示例展示了：

* Mustache 模板使用
* URL routing 以及 handlers
* URL Variables
* Static file 服务
* SQLite3 数据库相关操作

此工程由 Swift Package Manager 构建，Swift Package Manager 来自于 [Perfect](https://github.com/PerfectlySoft/Perfect) 

确保你的 Xcode 版本在 8.0以上。

## 准备工作 - 使用 Xcode 8

* 导出或者下载此工程
* 在命令台，导航到目录并执行：

```
swift package generate-xcodeproj
```

* 打开 `Perfect-Blog-Mustache.xcodeproj`

由于从 Xcode 运行静态文件的复杂性，我们建议从终端运行这个项目。

## 准备工作 - 使用终端

* 导出或下载工程
* 在终端中，导航到工程目录
* 执行 `swift build`
* 当 build 结束执行 `./.build/debug/Perfect-Blog-Mustache`

您将会看到如下输出：

```
[INFO] Starting HTTP server on 0.0.0.0:8181 with document root ./webroot
```

## 已包含的路由

* [http://localhost:8181](http://localhost:8181) - 博客文章列表页
* http://localhost:8181/story/{storyid} - 可从博客文章列表页中找到，展示博文详情

## 问题报告

目前我们已经把所有错误报告合并转移到了 JIRA 上，因此 github 原有的错误汇报功能不能用于本项目。

您的任何宝贵建意见或建议，或者发现我们的程序有问题，欢迎您在这里告诉我们。[http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1)

目前问题清单请参考以下链接：[http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)


## 更多内容
关于 Perfect 更多内容，请参考 [perfect.org](http://perfect.org) 官网。


