import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';

import '../utils/log_util.dart';
import 'base_controller.dart';

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
