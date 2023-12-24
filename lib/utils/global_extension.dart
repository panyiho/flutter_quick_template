import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'event_bus.dart';

extension ObjectExtension on Object {
  void sendEvent<T>({T? event}) {
    if (event == null) {
      EventBus().fire(this);
      return;
    }
    EventBus().fire(event);
  }
}

extension GestureExtension on Widget {
  GestureDetector onTab(GestureTapCallback tapCallback) {
    return GestureDetector(onTap: tapCallback, child: this);
  }

  GestureDetector onDoubleTab(GestureDoubleTapCallback tapCallback) {
    return GestureDetector(onDoubleTap: tapCallback, child: this);
  }

  GestureDetector onLongPress(GestureLongPressCallback tapCallback) {
    return GestureDetector(onLongPress: tapCallback, child: this);
  }
}

extension WidgetsExtension on Widget {
  Flexible flexible() {
    return Flexible(child: this);
  }

  Expanded expanded() {
    return Expanded(child: this);
  }

  SizedBox sizedBox({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  Align align(Alignment alignment,
      {double? widthFactor, double? heightFactor}) {
    return Align(
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }
}
