import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/core/ui/spaced_row.dart';
import 'package:ava_light/core/widgets/card_widget.dart';
import 'package:ava_light/credit_factors/models/credit_factor.dart';
import 'package:flutter/material.dart';

class CreditFactorsListWidget extends StatelessWidget {
  const CreditFactorsListWidget({super.key, required this.factors});

  final List<CreditFactor> factors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SpacedRow(
          spacing: 8,
          children: [
            for (CreditFactor factor in factors)
              CreditFactorCardWidget(factor: factor)
          ],
        ),
      ),
    );
  }
}

class CreditFactorCardWidget extends StatelessWidget {
  const CreditFactorCardWidget({super.key, required this.factor});

  final CreditFactor factor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final titleStyle = textTheme.labelLarge?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );

    final valueStyle = textTheme.labelLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AvaColors.purple,
    );

    return SizedBox(
      width: 144,
      height: 160,
      child: CardWidget(
        padding: EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Text(
              factor.title,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Text(
                factor.value,
                style: valueStyle,
                textAlign: TextAlign.center,
              ),
            ),
            CreditImpactWidget(impact: factor.impact)
          ],
        ),
      ),
    );
  }
}

class CreditImpactWidget extends StatelessWidget {
  const CreditImpactWidget({super.key, required this.impact});

  final CreditImpact impact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final textStyle = textTheme.bodyLarge?.copyWith(
      color: impact.textColor,
      fontSize: 11,
      fontWeight: FontWeight.w700,
    );

    return Container(
      decoration: ShapeDecoration(
        color: impact.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Text(
          impact.string,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
