// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:flutter_quick_template/page/event_test_page.dart';
import 'package:flutter_quick_template/page/home_page.dart';
import 'package:flutter_quick_template/page/http_page.dart';
import 'package:flutter_quick_template/page/light_storage_page.dart';

class RouteTable {
  static const String event = '/event';
  static const String home = '/home';
  static const String http = '/http';
  static const String lightStorage = '/lightStorage';

  static final List<GetPage> pages = [
    GetPage(name: '/event', page: () => EventTestPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/http', page: () => HttpPage()),
    GetPage(name: '/lightStorage', page: () => LightStoragePage()),
  ];
}

