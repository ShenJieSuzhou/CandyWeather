

import 'package:flutter/material.dart';

class PositionModel with ChangeNotifier{
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  void openPosition() {
    _isOpen = true;
    notifyListeners();
  }

  void closePosition() {
    _isOpen = false;
    notifyListeners();
  }
}



class NotificationModel with ChangeNotifier{
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  void openNotification() {
    _isOpen = true;
    notifyListeners();
  }

  void closeNotification() {
    _isOpen = false;
    notifyListeners();
  }
}