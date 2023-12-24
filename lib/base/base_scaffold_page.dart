import 'package:flutter/material.dart';

import 'base_controller.dart';
import 'base_page.dart';

abstract class BaseScaffoldPage<T extends BaseController> extends BasePage<T> {
  @override
  Widget buildWidget(BaseController controller) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  PreferredSizeWidget? getAppBar();

  Widget? getBody();

  Widget? getBottomNavigationBar() {
    return null;
  }
}
