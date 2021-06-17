import 'package:flutter/material.dart';

class TranslateViewModel extends ChangeNotifier {
  bool hovering = false;

  void mouseEnter(bool hover) {
    hovering = hover;
    notifyListeners();
  }
}
