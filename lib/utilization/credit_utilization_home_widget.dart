import 'package:auto_size_text/auto_size_text.dart';
import 'package:ava_light/accounts/providers/accounts_provider.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/core/widgets/card_widget.dart';
import 'package:ava_light/core/widgets/circular_progress_widget.dart';
import 'package:ava_light/utilization/models/credit_utilization_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CreditUtilizationHomeWidget extends ConsumerStatefulWidget {
  const CreditUtilizationHomeWidget({super.key});

  @override
  ConsumerState<CreditUtilizationHomeWidget> createState() =>
      _CreditUtilizationHomeWidgetState();
}

class _CreditUtilizationHomeWidgetState
    extends ConsumerState<CreditUtilizationHomeWidget> {
  double progressValue = 0.0;

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

    final totalBalance = ref.watch(totalAccountBalanceProvider);
    final totalLimit = ref.watch(totalAccountLimitProvider);

    final utilizationReport = ref.watch(creditUtilizationReportProvider);

    final percentFormatter = NumberFormat.percentPattern();

    return VisibilityDetector(
      key: Key("credit-utilization-card"),
      onVisibilityChanged: (info) {
        final visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage >= 80) {
          setState(() {
            progressValue = utilizationReport.ratio;
          });
        }
      },
      child: CardWidget(
        child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SpacedColumn(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Credit Utilization",
                        style: titleStyle,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Total Balance: ${totalBalance.toString()}",
                            style: subtitleStyle,
                            maxLines: 1,
                          ),
                          Text(
                            "Total Limit: ${totalLimit.toString()}",
                            style: subtitleStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CircularProgressWidget(
                  progressValue: progressValue,
                  maxValue: 1.0,
                  title: percentFormatter.format(utilizationReport.ratio),
                  subtitle: utilizationReport.grade.stringValue,
                  style: CircularProgressStyle.semi,
                ),
              ],
            ),
            // UtilizationGradeBar(),
          ],
        ),
      ),
    );
  }
}

class UtilizationGradeBar extends StatelessWidget {
  const UtilizationGradeBar({super.key});

  @override
  Widget build(BuildContext context) {
    final grades = UtilizationGrade.values
        .where(
          (element) => element != UtilizationGrade.unknown,
        )
        .toList()
        .reversed;

    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [for (var grade in grades) Expanded(child: createBar(grade))],
      ),
    );
  }

  Widget createBar(UtilizationGrade grade) {
    return Container(
      color: grade.colorValue,
    );
  }
}
