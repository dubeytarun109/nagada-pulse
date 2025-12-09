import 'dart:async';

class SyncEngine {
  final Duration interval;
  Timer? _timer;

  SyncEngine({this.interval = const Duration(seconds: 5)});

  void start() {
    _timer = Timer.periodic(interval, (_) => _sync());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _sync() async {
    // Implement networking to the server in a production client.
  }
}
