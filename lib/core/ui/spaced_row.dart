import 'package:flutter/widgets.dart';

class SpacedRow extends StatelessWidget {
  SpacedRow({
    super.key,
    this.spacing = 10.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    List<Widget> children = const <Widget>[],
  }) : children = _calculateChildren(children, spacing);

  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline?
      textBaseline; // NO DEFAULT: we don't know what the text's baseline should be
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }

  static List<Widget> _calculateChildren(
      List<Widget> children, double spacing) {
    if (children.isEmpty) return [];

    final List<Widget> newChildren = [];

    final lastIndex = children.length - 1;

    children.asMap().forEach((index, child) {
      newChildren.add(child);

      if (index != lastIndex) {
        newChildren.add(SizedBox(width: spacing));
      }
    });

    return newChildren;
  }
}
