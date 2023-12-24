import 'dart:async';

class EventBus {
  factory EventBus() => _getInstance();

  static EventBus _getInstance() {
    _instance ??= EventBus.normal();
    return _instance!;
  }

  static EventBus? _instance;

  StreamController _streamController;

  /// Controller for the event bus stream.
  StreamController get streamController => _streamController;

  /// Creates an [EventBus].
  ///
  /// If [sync] is true, events are passed directly to the stream's listeners
  /// during a [fire] call. If false (the default), the event will be passed to
  /// the listeners at a later time, after the code creating the event has
  /// completed.
  EventBus.normal({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  /// Instead of using the default [StreamController] you can use this constructor
  /// to pass your own controller.
  ///
  /// An example would be to use an RxDart Subject as the controller.
  EventBus.customController(StreamController controller)
      : _streamController = controller;

  /// Listens for events of Type [T] and its subtypes.
  ///
  /// The method is called like this: myEventBus.on<MyType>();
  ///
  /// If the method is called without a type parameter, the [Stream] contains every
  /// event of this [EventBus].
  ///
  /// The returned [Stream] is a broadcast stream so multiple subscriptions are
  /// allowed.
  ///
  /// Each listener is handled independently, and if they pause, only the pausing
  /// listener is affected. A paused listener will buffer events internally until
  /// unpaused or canceled. So it's usually better to just cancel and later
  /// subscribe again (avoids memory leak).
  ///
  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  Stream<dynamic> onTypes(List<Type> types) {
    if (types.isEmpty) {
      return streamController.stream;
    } else {
      return streamController.stream
          .where((event) => types.any((type) => event.runtimeType == type));
    }
  }

  /// Fires a new event on the event bus with the specified [event].
  ///
  void fire(event) {
    streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  ///
  void destroy() {
    _streamController.close();
  }
}
