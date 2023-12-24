import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Loading {
  static void show(
      {String msg = 'loading...',
      bool clickMaskDismiss = false,
      Duration? displayTime}) async {
    await SmartDialog.showLoading(
        msg: msg,
        clickMaskDismiss: clickMaskDismiss,
        displayTime: displayTime,
        usePenetrate: false);
  }

  static void dismiss() async {
    await SmartDialog.dismiss(status: SmartStatus.loading);
  }
}
