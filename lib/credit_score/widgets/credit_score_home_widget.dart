import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/core/widgets/card_widget.dart';
import 'package:ava_light/credit_score/models/credit_score.dart';
import 'package:ava_light/credit_score/providers/credit_score_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreditScoreHomeWidget extends ConsumerWidget {
  const CreditScoreHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(GetSortedExperianReportsProvider());
    final minScore = ref.watch(minReportedExperianScoreProvider);
    final maxScore = ref.watch(maxReportedExperianScoreProvider);

    final nextDate = DateTime.now().add(
      Duration(days: 30),
    );

    return CardWidget(
      child: SpacedColumn(
        spacing: 20,
        children: [
          _HeaderWidget(nextDateCheck: nextDate),
          _ChartWidget(
            reports: reports,
            minY: minScore.toDouble(),
            maxY: maxScore.toDouble(),
          ),
          _FooterWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key, required this.nextDateCheck});

  final DateTime nextDateCheck;

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

    final dateFormatter = DateFormat.MMMEd();
    final dateString = dateFormatter.format(nextDateCheck);

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Credit Score", style: titleStyle),
        Text("Updated Today • Next $dateString", style: subtitleStyle),
      ],
    );
  }
}

class _ChartWidget extends StatefulWidget {
  _ChartWidget(
      {super.key,
      required this.reports,
      required this.minY,
      required this.maxY});

  final List<CreditReport> reports;
  final double minY;
  final double maxY;

  @override
  State<_ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<_ChartWidget> with AfterLayoutMixin {
  List<FlSpot> spots = [];
  int x = 1;

  late double minY;
  late double maxY;

  @override
  void initState() {
    super.initState();

    minY = widget.minY;
    maxY = widget.maxY;

    for (int i = 0; i < widget.reports.length; i++) {
      final x = i + 1;

      spots.add(FlSpot(x.toDouble(), minY));
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final reports = widget.reports;

    final List<FlSpot> newSpots = [];

    for (int i = 0; i < reports.length; i++) {
      final report = reports[i];

      final x = i + 1;
      final y = report.score;

      newSpots.add(FlSpot(x.toDouble(), y.toDouble()));
    }

    setState(() {
      spots = newSpots;
    });
  }

  @override
  Widget build(BuildContext context) {
    final barData = loadBarData();

    final data = LineChartData(
      lineTouchData: touchData,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        checkToShowHorizontalLine: (value) {
          if (value == (minY + 1)) {
            return true;
          }

          return (value % 50 == 0);
        },
      ),
      titlesData: getTitlesData(context),
      borderData: FlBorderData(show: false),
      lineBarsData: barData,
      minX: 1,
      maxX: 12,
      minY: minY,
      maxY: maxY,
    );

    final titleStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AvaColors.purple,
        );

    return SpacedColumn(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.reports.first.agency.string, style: titleStyle),
        SizedBox(
          height: 100,
          child: LineChart(
            data,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          ),
        ),
      ],
    );
  }

  LineTouchData get touchData => LineTouchData(handleBuiltInTouches: false);

  FlTitlesData getTitlesData(BuildContext context) {
    final disabled = AxisTitles(sideTitles: SideTitles(showTitles: false));

    return FlTitlesData(
      bottomTitles: disabled,
      rightTitles: disabled,
      topTitles: disabled,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return getLeftTitleWidget(context, value, meta);
          },
          showTitles: true,
          interval: 1,
        ),
      ),
    );
  }

  List<LineChartBarData> loadBarData() {
    return [
      LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AvaColors.green,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (p0, p1, p2, p3) {
            return FlDotCirclePainter(
              color: Colors.white,
              strokeColor: Colors.green,
              strokeWidth: 2.0,
            );
          },
        ),
        spots: spots,
      ),
    ];
  }

  Widget getLeftTitleWidget(
      BuildContext context, double value, TitleMeta meta) {
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Color.fromRGBO(115, 107, 124, 1),
        );

    String text;
    if (value % 50 == 0) {
      text = value.toStringAsFixed(0);
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }
}

class _FooterWidget extends StatelessWidget {
  const _FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(42, 30, 57, 1),
    );

    final subtitleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color.fromRGBO(115, 107, 124, 1),
    );

    return Column(
      children: [
        Text("Last 12 Months", style: titleStyle),
        Text("Score calculated using VantageScore 3.0", style: subtitleStyle),
      ],
    );
  }
}
