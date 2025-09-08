import 'package:auto_size_text/auto_size_text.dart';
import 'package:ava_light/accounts/providers/accounts_provider.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/core/ui/spaced_row.dart';
import 'package:ava_light/core/widgets/card_widget.dart';
import 'package:ava_light/core/widgets/circular_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CreditUtilizationHomeWidget extends ConsumerStatefulWidget {
  const CreditUtilizationHomeWidget({super.key});

  @override
  ConsumerState<CreditUtilizationHomeWidget> createState() => _CreditUtilizationHomeWidgetState();
}

class _CreditUtilizationHomeWidgetState extends ConsumerState<CreditUtilizationHomeWidget>
    with AutomaticKeepAliveClientMixin {
  double progressValue = 0.0;
  bool _hasAnimated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final totalBalance = ref.watch(totalAccountBalanceProvider);
    final totalLimit = ref.watch(totalAccountLimitProvider);

    final utilizationReport = ref.watch(creditUtilizationReportProvider);

    final percentFormatter = NumberFormat.percentPattern();

    return VisibilityDetector(
      key: Key("credit-utilization-card"),
      onVisibilityChanged: (info) {
        final visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage >= 80 && !_hasAnimated) {
          setState(() {
            progressValue = utilizationReport.ratio;
            _hasAnimated = true;
          });
        }
      },
      child: CardWidget(
        child: SpacedColumn(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Total Credit Utilization",
              style: titleStyle,
            ),
            CircularProgressWidget(
              key: Key('credit-utilitzation-card-progress'),
              progressValue: utilizationReport.ratio,
              maxValue: 1.0,
              title: percentFormatter.format(utilizationReport.ratio),
              subtitle: utilizationReport.grade.stringValue,
              style: CircularProgressStyle.semi,
              animateOnce: true,
            ),
            Column(
              children: [
                Text(
                  "How is this calculated?",
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Your credit card utilization is found by dividing your total credit card balance by your total credit card limit.",
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SpacedRow(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ValueCard(
                    title: "Total Balance",
                    subtitle: totalBalance.toString(),
                  ),
                ),
                Text("÷", style: textTheme.titleLarge),
                Expanded(
                  child: ValueCard(
                    title: "Total Limit",
                    subtitle: totalLimit.toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ValueCard extends StatelessWidget {
  const ValueCard({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.labelLarge?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    final subtitleStyle = textTheme.labelLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AvaColors.purple,
    );

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
          side: BorderSide(color: AvaColors.cardBorderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AutoSizeText(
              title,
              style: titleStyle,
              maxLines: 1,
            ),
            AutoSizeText(
              subtitle,
              style: subtitleStyle,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
