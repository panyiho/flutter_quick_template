import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/event_bus.dart';
import 'page_life_state.dart';

class BaseController extends SuperController with PageLifeState {
  StreamSubscription? streamSubscription;
  @mustCallSuper
  @override
  void onReady() {
    super.onReady();
    var listenerEventList = getListenEvent();
    if (listenerEventList.isNotEmpty) {
      streamSubscription =
          EventBus().onTypes(listenerEventList).listen(onReceiveEvent);
    }
  }

  void onReceiveEvent(event) {}

  List<Type> getListenEvent() {
    return [];
  }

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    streamSubscription?.cancel();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
