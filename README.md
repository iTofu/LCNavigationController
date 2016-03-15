# LCNavigationController

[![Travis](https://img.shields.io/travis/LeoiOS/LCNavigationController.svg?style=flat)](https://travis-ci.org/LeoiOS/LCNavigationController)
[![CocoaPods](https://img.shields.io/cocoapods/v/LCNavigationController.svg)](http://cocoadocs.org/docsets/LCNavigationController)
[![CocoaPods](https://img.shields.io/cocoapods/l/LCNavigationController.svg)](https://raw.githubusercontent.com/LeoiOS/LCNavigationController/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/p/LCNavigationController.svg)](http://cocoadocs.org/docsets/LCNavigationController)
[![LeoDev](https://img.shields.io/badge/blog-LeoDev.me-brightgreen.svg)](http://leodev.me)

除 UINavigationController 外最流行的 NavigationController！

![image](https://github.com/LeoiOS/LCNavigationController/blob/master/LCNCDemo.gif)
===
![image](https://github.com/LeoiOS/LCNavigationController/blob/master/LCNCDemo.png)

  ````
  心有猛虎，细嗅蔷薇。
  ````

欢迎访问 **我的博客**：http://LeoDev.me


## 前言 Foreword

效果参考 App：腾讯新闻、百度音乐等等



#### 配合`UITabBarController`使用请参考 [tabbar](https://github.com/LeoiOS/LCNavigationController/tree/tabbar) 分支！

**效果图：**

![image](https://github.com/LeoiOS/LCNavigationController/blob/tabbar/LCNCTabbarDemo.gif)



## 代码 Code

> 当成`UINavigationController`来用就行！方法都一样！
>
> 配合`UITabBarController`使用请参考 [tabbar](https://github.com/LeoiOS/LCNavigationController/tree/tabbar) 分支！

* 
    - 方法一：[CocoaPods](https://cocoapods.org/) 导入：`pod 'LCNavigationController'`
    - 方法二：导入`LCNavigationController`文件夹到你的项目中 (文件夹在 Demo 中可以找到)
* 在`AppDelegate.m`中，`#import "LCNavigationController.h"`，参考如下代码：

    ````objc
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window makeKeyAndVisible];

        UIViewController *mainVC = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;

        LCNavigationController *navC = [[LCNavigationController alloc] initWithRootViewController:mainVC];

        self.window.rootViewController = navC;

        return YES;
    }
    ````
* 在你需要用到的地方`#import "LCNavigationController.h"`，然后：
    ````objc
    // 1. Push
    UIViewController *childVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TwoVC"];
    [self.lcNavigationController pushViewController:childVC];

    // 2. Pop
    [self.lcNavigationController popViewController];

    // 3. Pop to rootViewController
    [self.lcNavigationController popToRootViewController];
    ````
* 可自定义的参数(在`LCNavigationController.m`中)：
    ````objc
    static const CGFloat LCAnimationDuration = 0.50f;   // Push / Pop 动画持续时间

    static const CGFloat LCMaxBlackMaskAlpha = 0.80f;   // 黑色背景透明度

    static const CGFloat LCZoomRatio         = 0.90f;   // 后面视图缩放比

    static const CGFloat LCShadowOpacity     = 0.80f;   // 滑动返回时当前视图的阴影透明度

    static const CGFloat LCShadowRadius      = 8.00f;   // 滑动返回时当前视图的阴影半径
    ````
* 搞定！



## 更新日志 2015.11.24 Update Logs (Tag: 1.0.2 branch: tabbar)
* 提供配合`UITabBarController`使用的 Demo，详见 [tabbar](https://github.com/LeoiOS/LCNavigationController/tree/tabbar) 分支。



## 更新日志 2015.11.23 Update Logs (Tag: 1.0.2)
* 更新自定义参数。



## 更新日志 2015.11.20 Update Logs (Tag: 1.0.0)
* 初始化提交。



## 联系 Support

* 发现问题请 Issues 我，谢谢:-)
* Email: leoios@sina.com
* Blog: http://www.leodong.com



## 授权 License

本项目采用 [MIT license](http://opensource.org/licenses/MIT) 开源，你可以利用采用该协议的代码做任何事情，只需要继续继承 MIT 协议即可。
