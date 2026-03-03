import 'package:elbe/src/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class ElbeFlex extends StatelessWidget {
  final Axis axis;
  final MainAxisAlignment main;
  final CrossAxisAlignment cross;
  final MainAxisSize mainAxisSize;
  final TextDirection textDirection;
  final TextBaseline textBaseline;
  //final bool reversed;
  final double gap;
  final List<Widget> children;

  const ElbeFlex({
    super.key,
    required this.axis,
    required this.main,
    required this.cross,
    required this.mainAxisSize,
    required this.textDirection,
    required this.textBaseline,
    required this.gap,
    //required this.reversed,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final remSize = Theme.maybeOf(context)?.geometry.remSize ?? 16;

    return Flex(
      direction: axis,
      mainAxisAlignment: main,
      crossAxisAlignment: cross,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      textBaseline: textBaseline,
      spacing: gap * remSize,
      children: children,
    );
  }
}

class Column extends ElbeFlex {
  const Column({
    super.key,
    super.main = MainAxisAlignment.start,
    super.cross = CrossAxisAlignment.stretch,
    super.mainAxisSize = MainAxisSize.min,
    super.textDirection = TextDirection.ltr,
    super.textBaseline = TextBaseline.alphabetic,
    super.gap = 1,
    //super.reversed = false,
    super.children = const [],
  }) : super(axis: Axis.vertical);
}

class Row extends ElbeFlex {
  const Row({
    super.key,
    super.main = MainAxisAlignment.start,
    super.cross = CrossAxisAlignment.center,
    super.mainAxisSize = MainAxisSize.min,
    super.textDirection = TextDirection.ltr,
    super.textBaseline = TextBaseline.alphabetic,
    super.gap = 1,
    //super.reversed = false,
    super.children = const [],
  }) : super(axis: Axis.horizontal);
}
