import 'package:flutter/material.dart';
import 'package:flutter_quick_template/utils/global_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_route_annotations/getx_route_annotations.dart';

import '../base/LightStorage/light_storage.dart';
import '../base/base_controller.dart';
import '../base/base_scaffold_page.dart';
import '../utils/toast_util.dart';

@GetXRoutePage("/lightStorage")
class LightStoragePage extends BaseScaffoldPage {
  String KEY = "key_save";
  TextEditingController textController = TextEditingController();

  @override
  BaseController generateController() {
    return LIghtStoragePageController();
  }

  @override
  PreferredSizeWidget? getAppBar() {
    return AppBar(
      leading: const Icon(Icons.arrow_back).onTab(() {
        Get.back();
      }),
      title: const Text("LightStorage"),
    );
  }

  @override
  Widget? getBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
              ).sizedBox(width: 100.w),
              ElevatedButton(
                  onPressed: () {
                    LightStorage.getInstance()
                        .putString(KEY, textController.text);
                  },
                  child: const Text("save"))
            ],
          ).marginOnly(bottom: 10.h),
          ElevatedButton(
              onPressed: () {
                Toast.show(LightStorage.getInstance().getString(KEY));
              },
              child: const Text("getSaveContent"))
        ]).align(Alignment.center);
  }
}

class LIghtStoragePageController extends BaseController {}
