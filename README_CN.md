# flutter_quick_template 
Language: 中文 | [English](README.md)

这是一款基于第三方开源库搭建的flutter基础开发架构框架，提供了很多方便易用的工具类和方法，用于快速搭建和开启一个新的flutter项目，当前项目用到了以下几个开源库，非常感谢他们的开源贡献。

- [getx_route_generator ](https://github.com/panyiho/getx_route_generator)
- [getx](https://github.com/jonataslaw/getx)
- [flutter_screenutil](https://github.com/OpenFlutter/flutter_screenutil)
- [lifecycle](https://github.com/chenenyu/lifecycle)
- [shared_preferences](https://github.com/flutter/packages/tree/main/packages/shared_preferences/shared_preferences)
- [dio](https://github.com/cfug/dio/tree/main/dio)
- [logger](https://github.com/SourceHorizon/logger)
- [retrofit](https://github.com/trevorwang/retrofit.dart/)
- [json_annotation](https://github.com/google/json_serializable.dart/tree/master/json_annotation)
- [cached_network_image](https://github.com/Baseflow/flutter_cached_network_image)
- [flutter_smart_dialog](https://github.com/fluttercandies/flutter_smart_dialog)
- [mmkv](https://github.com/Tencent/mmkv)
- [styled_widget](https://github.com/ReinBentdal/styled_widget)
- [pretty_dio_logger](https://github.com/Milad-Akarie/pretty_dio_logger)

  
## 使用方式
### BasePage和BaseController  
 BasePage继承于get的getView，对应着一个单独的路由页面，同时利用LifeCycle库提供页面显示的生命周期回调，分别为：  
 onPageActive,  
 onPageVisible,  
 onPageInActive,  
 onPageInVisible  
 ,对应着页面激活，页面可见，页面不可见等状态，类似于Android Activity的onResume回调，这里因为没有用到getx的bindings功能，所以需要自己复写generateController方法提供当前页面绑定的BaseController。
``` dart
abstract class BasePage<T extends BaseController> extends GetView<T> {
  BuildContext? context;

  T generateController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Get.put(generateController());
    return LifecycleWrapper(
        onLifecycleEvent: (LifecycleEvent lifecycleEvent) {
          logI("$runtimeType $lifecycleEvent");
          switch (lifecycleEvent) {
            case LifecycleEvent.visible:
              controller.onPageVisible();
              break;
            case LifecycleEvent.inactive:
              controller.onPageInActive();
              break;
            case LifecycleEvent.active:
              controller.onPageActive();
              break;
            case LifecycleEvent.invisible:
              controller.onPageInVisible();
              break;
            default:
          }
        },
        child: GetBuilder<T>(
          builder: buildWidget,
          assignId: true,
        ));
  }

  Widget buildWidget(T controller);
}

```

#### BaseController  
BaseController继承于get的SuperController，因此，SuperController拥有的关于app的生命周期回调BaseController一样拥有，同时还有上面BasePage拥有的关于路由页面的生命周期回调，不但如此，还提供eventBus事件监听功能，可以在不同的BaseController之间进行基于eventBus的事件通信。只需要复写getListenEvent方法返回你需要监听的event事件类型，当其他地方发送监听的事件后，就会通过onReceiveEvent方法回调给当前的BaseController，类似这样：
```  dart
class HomePageController extends BaseController {
  @override
  List<Type> getListenEvent() {
    return [CustomTextEvent];
  }

  @override
  void onReceiveEvent(event) {
    switch (event.runtimeType) {
      case CustomTextEvent:
        Toast.show(event.text);
        break;
      default:
    }
  }
  ```
在onReady的时候BaseController会自动帮你注册getListenEvent的需要关注的事件，同时在页面onClose的时候会自动接注册eventBus的事件监听，不需要手动处理。

### 页面路由表生成
因为用到get的路由功能，为了避免手写路由降低效率，这里用到了我写的另外一个开源库 `getx_route_generator`,只需要在BasePage上面添加`GetXRoutePage`注解然后运行命令行指令就可以生成一份路由表。生成的代码如下：
``` dart 
// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:flutter_quick_template/page/home_page.dart';

class RouteTable {
  static const String home = '/home';

  static final List<GetPage> pages = [
    GetPage(name: '/home', page: () => HomePage()),
  ];
}

```
详情可以了解下：[getx_route_generator](https://pub.dev/packages/getx_route_generator)


### 轻量级存储  
 在App的开发过程中，我们经常需要保存一些key-value的持久化数据或者配置，在Android中经常用到的就是shared_preferences，而ios对应的就是NSUserDefaults
 ，本项目提供了基于shared_preferences和MMKV的封装类，开箱即用，根据需要选择即可，用法：  
 ``` dart
 LightStorage.getString(key,defaultValue)
 LightStorage.clear()
 LightStorage.putString(key,defaultValue)
 LightStorage.containsKey(key)
 LightStorage.remove(key)
 ```

 ### Utils工具类
 本项目提供常用的三种工具类，一个是loading,toast,和log，之所以封装起来，是为了隔离依赖，如果你的项目需要定制或者不一样的底层实现，就可以很方便的切换而不需要修改很多的代码。

  #### Loading
  ``` dart
  Loading.show()
  Loading.dismiss()
  ```

 #### toast
  ``` dart
  Toast.show()
  ```

  
   #### log
  ``` dart
logV("log msg")

logD("log msg")

logI("log msg")

logW("log msg")

logE("log msg")

logWTF("log msg")

  ```
 ### Extensions
 #### EventBus
 可以直接发送：
 ``` dart
  CustomTextEvent(text: "msg from EventTestPage").sendEvent();
 ```
  #### GestureDetector
 ``` dart
   Text("onTab").onTab((){});
   Text("onDoubleTab").onDoubleTab((){});
   Text("onLongPress").onLongPress((){});
 ```
  #### Widgets
  都调用styled_widget库的extensions方法，就像这样：  
  ``` dart
  Icon(OMIcons.home, color: Colors.white)
  .padding(all: 10)
  .decorated(color: Color(0xff7AC1E7), shape: BoxShape.circle)
  .padding(all: 15)
  .decorated(color: Color(0xffE8F2F7), shape: BoxShape.circle)
  .padding(all: 20)
  .card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  )
  .alignment(Alignment.center)
  .backgroundColor(Color(0xffEBECF1));
  ```
更多用法可以查阅styled_widget的官网  
https://github.com/ReinBentdal/styled_widget


 ### Http
 Http请求是结合了dio和retrofit两个开源库实现的，如下：
 ``` dart 
        Result<TestInfo> result = await Http.client().getInfo();
              Toast.show("${result.data}");
 ```
 详情可以阅读源码