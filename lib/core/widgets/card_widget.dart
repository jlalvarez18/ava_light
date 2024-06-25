import 'package:ava_light/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AvaColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: AvaColors.cardBorderColor),
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
