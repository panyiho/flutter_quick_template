import 'package:logger/logger.dart';
import 'dart:developer';

bool isDebug = const bool.fromEnvironment('dart.vm.product') != true;
Logger _logger = Logger(
  printer: PrettyPrinter(
      stackTraceBeginIndex: 1, printTime: true, noBoxingByDefault: false),
);

logV(dynamic msg) {
  if (isDebug) {
    _logger.t("$msg");
  }
}

logD(dynamic msg) {
  if (isDebug) {
    _logger.d("$msg");
  }
}

logI(dynamic msg) {
  if (isDebug) {
    _logger.i("$msg");
  }
}

logW(dynamic msg) {
  if (isDebug) {
    _logger.w("$msg");
  }
}

logE(dynamic msg) {
  if (isDebug) {
    _logger.e("$msg");
  }
}

logWTF(dynamic msg) {
  if (isDebug) {
    log(msg);
  }
}
