import 'package:flutter/material.dart';
import 'dart:async';
import '../models/countdown_model.dart';

class CountdownViewModel with ChangeNotifier {
  CountdownModel _model = CountdownModel();
  Timer? _timer;

  bool get isPlaying => _model.isPlaying;
  String get currentYear => _model.currentYear;
  String get nextYear => _model.nextYear;
  bool get showCountdown => _model.showCountdown;
  int get secondsLeft => _model.secondsLeft;

  void startCountdown() {
    _model.showCountdown = true;
    _model.secondsLeft = 10;
    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_model.secondsLeft > 0) {
        _model.secondsLeft--;
        notifyListeners();
      } else {
        _timer?.cancel();
        startAnimation();
      }
    });
  }

  void startAnimation() {
    _model.isPlaying = true;
    _model.showCountdown = false;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    _model.isPlaying = false;
    _model.showCountdown = false;
    _model.secondsLeft = 10;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
