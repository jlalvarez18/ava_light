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
    final reports = ref.watch(getExperianReportsProvider);

    final nextDate = DateTime.now().add(
      Duration(days: 30),
    );

    return CardWidget(
      child: SpacedColumn(
        spacing: 20,
        children: [
          _HeaderWidget(nextDateCheck: nextDate),
          _ChartWidget(reports: reports),
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
  _ChartWidget({super.key, required this.reports});

  final List<CreditReport> reports;

  @override
  State<_ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<_ChartWidget> with AfterLayoutMixin {
  late Iterator<CreditReport> reversedReports;
  late Timer timer;

  List<FlSpot> spots = [];
  int x = 1;

  @override
  void initState() {
    super.initState();

    reversedReports = widget.reports.reversed.iterator;
    addNextSpot();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  void addNextSpot() {
    if (!reversedReports.moveNext()) {
      return;
    }

    final report = reversedReports.current;
    final y = report.score;

    setState(() {
      spots.add(FlSpot(x.toDouble(), y.toDouble()));
    });

    x += 1;
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    timer = Timer.periodic(
      Duration(milliseconds: 40),
      (timer) {
        addNextSpot();
      },
    );
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
          return value == 601 || value == 650 || value == 699;
        },
      ),
      titlesData: getTitlesData(context),
      borderData: FlBorderData(show: false),
      lineBarsData: barData,
      minX: 1,
      maxX: 12,
      minY: 600,
      maxY: 700,
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
            curve: Curves.bounceInOut,
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
          reservedSize: 44,
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
    switch (value.toInt()) {
      case 700:
        text = '700';
      case 650:
        text = '650';
      case 600:
        text = '600';
      case 550:
        text = '550';
      default:
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
