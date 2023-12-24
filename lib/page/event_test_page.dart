import 'package:flutter/material.dart';
import 'package:getx_route_annotations/getx_route_annotations.dart';
import '../utils/global_extension.dart';
import 'package:get/get.dart';

import '../base/base_controller.dart';
import '../base/base_scaffold_page.dart';
import '../events/text_event.dart';

@GetXRoutePage("/event")
class EventTestPage extends BaseScaffoldPage<EventTestController> {
  @override
  EventTestController generateController() {
    return EventTestController();
  }

  @override
  PreferredSizeWidget? getAppBar() {
    return AppBar(
      leading: const Icon(Icons.arrow_back).onTab(() {
        Get.back();
      }),
      title: const Text("EventTestPage"),
    );
  }

  @override
  Widget? getBody() {
    return ElevatedButton(
            onPressed: () {
              CustomTextEvent(text: "msg from EventTestPage").sendEvent();
            },
            child: const Text("send Event to HomePage"))
        .align(Alignment.center);
  }
}

class EventTestController extends BaseController {
  @override
  void onReady() {
    super.onReady();
  }
}
