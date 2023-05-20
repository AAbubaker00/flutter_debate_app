import 'package:debate/shared/themes/themes.dart';
import 'package:debate/shared/units/units.dart';
import 'package:flutter/material.dart';

class CWListView extends StatelessWidget {
  final List<Widget> children;

  final EdgeInsets padding;

  final Widget centerWidget;

  final ScrollPhysics physics;

  final ScrollController scrollController;

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const CWListView(
      {Key? key,
      required this.children,
      this.padding = const EdgeInsets.all(0),
      this.physics = const ScrollPhysics(),
      required this.centerWidget,
      required this.scrollController,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return centerWidget == null
        ? RawScrollbar(
            interactive: false,
            thickness: 3,
            thumbColor: textColorVarient,
            radius: Radius.circular(circularRadius * 2),
            child: SingleChildScrollView(
                controller: scrollController,
                physics: physics,
                padding: padding,
                child: Column(
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                )),
          )
        : centerWidget;
  }
}
