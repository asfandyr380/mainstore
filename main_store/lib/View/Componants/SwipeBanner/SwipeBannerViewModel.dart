import 'package:flutter/material.dart';

class SwipeBannerViewModel extends ChangeNotifier {
  int currentIndex = 0;

  onPageChange(int i) {
    currentIndex = i;
    notifyListeners();
  }
}
