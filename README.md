# flutter_quick_template 
Language: [中文](README_CN.md) | English  

This is a Flutter basic development framework built on third-party open-source libraries, providing convenient and easy-to-use utility classes and methods for quickly setting up a new Flutter project. The current project utilizes the following open-source libraries, and we express our gratitude for their contributions:

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

  
## Usage

### BasePage and BaseController  
`BasePage` inherits from `GetView` of GetX, corresponding to a separate route page. It also utilizes the `Lifecycle` library to provide lifecycle callbacks for page display, including:

- `onPageActive`
- `onPageVisible`
- `onPageInActive`
- `onPageInVisible`

These correspond to page activation, visibility, inactivity, and invisibility, similar to the `onResume` callback in Android's `Activity`. Here, since we are not using GetX's bindings feature, you need to override the `generateController` method to provide the `BaseController` bound to the current page.

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
### BaseController
BaseController inherits from SuperController of GetX. Therefore, BaseController has the app lifecycle callbacks just like SuperController. Additionally, it has the page lifecycle callbacks mentioned above and provides eventBus event listening, enabling event communication between different BaseController instances. Simply override the getListenEvent method to return the types of events you want to listen for, and the onReceiveEvent method will be called when an event of that type is sent.

``` dart
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
}
```
BaseController automatically registers and unregisters eventBus event listeners in onReady and onClose, respectively, eliminating the need for manual handling.

### Generating Page Routing Table
To simplify the use of get for routing purposes and improve efficiency, I've created an open-source library called `getx_route_generator`. By adding the GetXRoutePage annotation to the BasePage and running a simple command, a handy routing table is automatically created. Here's an example of the generated code:
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
For more details, check out :[getx_route_generator](https://pub.dev/packages/getx_route_generator)

### Lightweight Storage
In the development of an app, there is often a need to persistently store key-value data or configurations. On Android, SharedPreferences is commonly used, and on iOS, it corresponds to NSUserDefaults. This project provides encapsulated classes based on SharedPreferences and MMKV for out-of-the-box use. Choose according to your needs:

``` dart
LightStorage.getString(key, defaultValue);
LightStorage.clear();
LightStorage.putString(key, defaultValue);
LightStorage.containsKey(key);
LightStorage.remove(key);
```
### Utils Utility Classes
This project provides three utility classes for commonly used features: loading, toast, and log. They are encapsulated to isolate dependencies, allowing for easy switching without modifying a lot of code if customization or different underlying implementations are required.

#### Loading
``` dart
Loading.show();
Loading.dismiss();
```
#### Toast
``` dart
Toast.show();
```
#### Log
``` dart
logV("log msg");
logD("log msg");
logI("log msg");
logW("log msg");
logE("log msg");
logWTF("log msg");
```
#### Extensions
EventBus
You can directly send events:

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
All use the extensions method from the styled_widget library, like this:

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
For more usage, refer to the styled_widget library's official documentation: https://github.com/ReinBentdal/styled_widget

#### Http
HTTP requests are implemented using the dio and retrofit libraries, as shown below:

``` dart
Result<TestInfo> result = await Http.client().getInfo();
Toast.show("${result.data}");
```
For more details, please refer to the source code.

