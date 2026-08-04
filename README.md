# ![](https://github.com/dart-lang/logos/blob/master/flutter/icon/64.png?raw=true)yande

一个 [yande](http://yande.re) 的第三方 app .可以下载和查看 图片，并且收藏图片和将 tag 加入快捷搜索栏。

## 预览

![](https://raw.githubusercontent.com/xiao-po/readme_image/master/image/yandeIndexPage.jpg)
![](https://raw.githubusercontent.com/xiao-po/readme_image/master/image/yandeRightDrawer.jpg)
![](https://raw.githubusercontent.com/xiao-po/readme_image/master/image/yandeSettingView.jpg)

## 目录结构

```
|-- android
|   |-- app // Android 代码
|-- lib
|   |-- dao // 数据库相关代码
|   |-- model // model 对象
|   |-- route // 路由 
|   |-- service // service 方法
|   |-- utils // 工具类
|   |-- view // view 
|   `-- widget // 公共组件
`-- test
```

## build

1. 安装 Flutter stable（便携 zip 或 git clone 均可）。
2. 运行 `flutter pub get` 获取依赖。
3. 运行 `dart run build_runner build --delete-conflicting-outputs` 重新生成
   `lib/model/*.g.dart`（枚举序列化由 `@JsonValue` 注解保证，无需手工改 map）。
4. 运行 `flutter test` 与 `flutter analyze` 验证。
5. 运行 `flutter build apk --debug`，APK 位于
   `build/app/outputs/flutter-apk/app-debug.apk`。

> 注意：release 签名已从仓库移除，打包 release 需自行配置本地 keystore（环境变量方式）。

## 第三方依赖


*  [dio](https://pub.dartlang.org/packages/dio)
*  [cached_network_image](https://pub.dartlang.org/packages/cached_network_image)
*  [sqflite](https://pub.dartlang.org/packages/sqflite)
*  [share_extend](https://pub.dartlang.org/packages/share_extend)
*  [photo_view](https://pub.dartlang.org/packages/photo_view)
*  [json_annotation](https://pub.dartlang.org/packages/json_annotation)
*  [path_provider](https://pub.dartlang.org/packages/path_provider)
*  [shared_preferences](https://pub.dartlang.org/packages/shared_preferences)
*  [path](https://pub.dartlang.org/packages/path)


