import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget? child;
  const Layout({required this.child});
  @override
  Widget build(BuildContext context) {
    return child ?? Container();
  }
}
