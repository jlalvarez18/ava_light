import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/credit_score/models/credit_score.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class CreditScoreHeader extends StatelessWidget {
  const CreditScoreHeader({super.key, required this.report});

  final CreditReport report;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final subtitleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color.fromRGBO(115, 107, 124, 1),
    );

    final agencyStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(164, 72, 255, 1),
    );

    return Container(
      decoration: ShapeDecoration(
        color: AvaColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                SpacedColumn(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Credit Score", style: titleStyle),
                    Text("Updated Today | Next UNKNOWN", style: subtitleStyle),
                  ],
                ),
                Text(report.agency.string, style: agencyStyle),
              ],
            ),
            _CreditScoreWidget(report: report),
          ],
        ),
      ),
    );
  }
}

class _CreditScoreWidget extends StatelessWidget {
  const _CreditScoreWidget({super.key, required this.report});

  final CreditReport report;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final scoreStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 27,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final ratingStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    return SizedBox(
      height: 90,
      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1.0,
        startAngle: 180,
        corners: StrokeCap.butt,
        animation: true,
        progress: report.score.toDouble(),
        maxProgress: kMaxScoreRating.toDouble(),
        foregroundStrokeWidth: 10,
        backgroundStrokeWidth: 10,
        foregroundColor: Color.fromRGBO(72, 163, 136, 1),
        backgroundColor: Color.fromRGBO(169, 234, 206, 1),
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(report.score.toString(), style: scoreStyle),
                Text(report.rating.string, style: ratingStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
