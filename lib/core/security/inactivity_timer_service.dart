import 'dart:async';
import 'package:flutter/widgets.dart';

/// Inactivity Timer Service to automatically lock the app after a configured duration
class InactivityTimerService {
  final VoidCallback onLockRequired;
  int _timeoutSeconds;
  Timer? _timer;
  DateTime _lastActiveTime = DateTime.now();

  InactivityTimerService({
    required this.onLockRequired,
    int timeoutSeconds = 300, // 5 minutes default
  }) : _timeoutSeconds = timeoutSeconds;

  int get timeoutSeconds => _timeoutSeconds;

  void updateTimeout(int seconds) {
    _timeoutSeconds = seconds;
    recordActivity();
  }

  /// Records any user touch/interaction
  void recordActivity() {
    _lastActiveTime = DateTime.now();
    _resetTimer();
  }

  /// Called when app goes into background / paused
  void handleAppPaused() {
    _timer?.cancel();
  }

  /// Called when app returns to foreground / resumed
  void handleAppResumed() {
    if (_timeoutSeconds <= 0) {
      // Immediate lock on background
      onLockRequired();
      return;
    }

    final elapsed = DateTime.now().difference(_lastActiveTime).inSeconds;
    if (elapsed >= _timeoutSeconds) {
      onLockRequired();
    } else {
      recordActivity();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    if (_timeoutSeconds > 0) {
      _timer = Timer(Duration(seconds: _timeoutSeconds), () {
        onLockRequired();
      });
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
