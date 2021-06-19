import 'package:flutter/material.dart';
import 'package:main_store/View/Widgets/Hover_Widgets/TranslateOnHoverViewModel.dart';
import 'package:stacked/stacked.dart';

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  TranslateOnHover({required this.child});

  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);

  final hoverTransform = Matrix4.identity()..translate(0, 0, 10);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TranslateViewModel>.reactive(
      builder: (context, model, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => model.mouseEnter(true),
        onExit: (e) => model.mouseEnter(false),
        child: Container(
          // duration: const Duration(milliseconds: 200),
          child: child,
          transform: model.hovering ? hoverTransform : nonHoverTransform,
        ),
      ),
      viewModelBuilder: () => TranslateViewModel(),
    );
  }
}
