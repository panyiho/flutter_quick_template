import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Toast {
  static show(String msg, {Duration? displayTime}) {
    SmartDialog.showToast(msg, displayTime: displayTime);
  }
}
