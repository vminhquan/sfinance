import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinProvider with ChangeNotifier {
  String? _savedPin;
  bool _isLocked = true;

  String? get savedPin => _savedPin;
  bool get isLocked => _isLocked;

  PinProvider() {
    _loadPin();
  }

  // Tải mã PIN từ bộ nhớ máy
  Future<void> _loadPin() async {
    final prefs = await SharedPreferences.getInstance();
    _savedPin = prefs.getString('user_pin');
    notifyListeners();
  }

  // Cài đặt mã PIN mới (Dành cho lần đầu sử dụng)
  Future<void> setPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_pin', pin);
    _savedPin = pin;
    notifyListeners();
  }

  // Mở khóa app
  void unlock() {
    _isLocked = false;
    notifyListeners();
  }
}