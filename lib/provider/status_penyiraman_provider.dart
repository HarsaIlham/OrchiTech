import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:orchitech/controllers/status_penyiraman_controller.dart';

class StatusPenyiramanProvider extends ChangeNotifier {
  final _controller = StatusPenyiramanController();
  StreamSubscription<bool>? _subscription1;
  StreamSubscription<bool>? _subscription2;

  bool _status1 = false;
  bool _status2 = false;
  bool get status1 => _status1;
  bool get status2 => _status2;

  StatusPenyiramanProvider() {
    _listenStatus1();
    _listenStatus2();
  }

  void _listenStatus1() {
    _subscription1 = _controller.getStatusPenyiraman1().listen((newStatus) {
      _status1 = newStatus;
      notifyListeners();
    });
  }

  void _listenStatus2() {
    _subscription2 = _controller.getStatusPenyiraman2().listen((newStatus) {
      _status2 = newStatus;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription1?.cancel();
    _subscription2?.cancel();
    super.dispose();
  }
}
