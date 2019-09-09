## SwiftModul

### 一个 iOS 项目的骨架（Swift）

### 环境
- Xcode10.2
- Swift5.0

### 包管理 

- Cocoapods
- 使用 Bundler 来管理 CocoaPods 版本，避免多人开发时版本冲突。

Cocoapods 和 Bundler 详细说明可以看这里[详细说明](https://www.jianshu.com/p/737d3fa5e12a)

### 代码规范

- 使用了 [SwiftLint](https://github.com/realm/SwiftLint)

### 项目架构

- 采用 [RxSwift](https://github.com/ReactiveX/RxSwift) + [ReactorKit](https://github.com/ReactorKit/ReactorKit) 的架构 

![nejggO.png](https://s2.ax1x.com/2019/09/05/nejggO.png)

在这个架构下一个简单的网络请求 Demo 可以查看 FindViewController.swift 和 FindReactor.swift 两个文件。

### 网络层

- 采用了 [RxSwift](https://github.com/ReactiveX/RxSwift) 和 [Moya](https://github.com/Moya/Moya)

[![nJD1H0.png](https://s2.ax1x.com/2019/09/09/nJD1H0.png)](https://imgchr.com/i/nJD1H0)

代码部分在 NetWork 和 Service 两个文件夹下。

### 单元测试

在目前的的架构下网络层的单元测试主要测试 server 的文件，UI 逻辑方面主要测试 reactor 文件。demo 可以查看 FindReactorTests.swift 和 findSeviceTests 两个文件。

### 其他

- 常用的工具类： 查看Utils文件夹
- 常用的扩展：查看Extension文件夹
- 常用协议：查看Protocol文件夹
- 常用组件：查看Module文件夹


