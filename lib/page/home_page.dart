import 'package:flutter/material.dart';
import 'package:flutter_quick_template/generated/route_table.dart';
import 'package:flutter_quick_template/utils/global_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_route_annotations/getx_route_annotations.dart';
import '../base/base_controller.dart';
import '../base/base_scaffold_page.dart';
import '../events/text_event.dart';
import '../utils/loading_util.dart';
import '../utils/log_util.dart';
import '../utils/toast_util.dart';

@GetXRoutePage("/home")
class HomePage extends BaseScaffoldPage<HomePageController> {
  @override
  HomePageController generateController() {
    return HomePageController();
  }

  @override
  PreferredSizeWidget? getAppBar() {
    return AppBar(
      title: const Text("flutter_quick_template"),
    );
  }

  @override
  Widget? getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
                onPressed: () async {
                  Loading.show();
                  await Future.delayed(2.seconds);
                  Loading.dismiss();
                },
                child: const Text("Loading example"))
            .marginOnly(bottom: 10.h),
        ElevatedButton(
                onPressed: () async {
                  Toast.show("test toast");
                },
                child: const Text("Toast example"))
            .marginOnly(bottom: 10.h),
        ElevatedButton(
                onPressed: () async {
                  Get.toNamed(RouteTable.event);
                },
                child: const Text("Event example"))
            .marginOnly(bottom: 10.h),
        ElevatedButton(
                onPressed: () async {
                  Get.toNamed(RouteTable.http);
                },
                child: const Text("Http mock example"))
            .marginOnly(bottom: 10.h),
        ElevatedButton(
                onPressed: () async {
                  Get.toNamed(RouteTable.lightStorage);
                },
                child: const Text("lightStorage example"))
            .marginOnly(bottom: 10.h),
      ],
    ).align(Alignment.center);
  }
}

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

  @override
  void onClose() {
    super.onClose();
    logI("onClose");
  }

  @override
  void onPageActive() {
    super.onPageActive();
    logI("$runtimeType onPageActive");
  }

  @override
  void onPageInVisible() {
    super.onPageInVisible();
    logI("$runtimeType onPageInVisible");
  }

  @override
  void onPageVisible() {
    super.onPageVisible();
    logI("$runtimeType onPageVisible");
  }

  @override
  void onPageInActive() {
    super.onPageInActive();
    logI("$runtimeType onPageInActive");
  }
}
