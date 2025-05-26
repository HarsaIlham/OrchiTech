import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:orchitech/controllers/aktivasi_pendingin_controller.dart';

class StatusPendinginProvider extends ChangeNotifier {
  final AktivasiPendinginController _controller = AktivasiPendinginController();
  StreamSubscription<bool>? _subscription;

  bool _status = false;
  bool get status => _status;

  StatusPendinginProvider() {
    _listenStatus();
  }

  void _listenStatus() {
    _subscription = _controller.getStatus().listen((newStatus) {
      _status = newStatus;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
