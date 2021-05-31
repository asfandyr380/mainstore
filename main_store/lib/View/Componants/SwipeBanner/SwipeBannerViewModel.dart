import 'package:flutter/material.dart';

class SwipeBannerViewModel extends ChangeNotifier {
  List<Widget> banner = [
    Center(child: Text('Banner View_1')),
    Center(child: Text('Banner View_2')),
    Center(child: Text('Banner View_3')),
  ];

  int currentIndex = 0;

  onPageChange(int i) {
    currentIndex = i;
    notifyListeners();
  }
}
