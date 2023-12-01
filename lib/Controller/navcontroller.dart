import 'package:flutter/material.dart';

class BottomNavController extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  changeIndex(int value) {
    _index = value;
    notifyListeners();
  }

  jumptoIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
