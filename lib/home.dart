import 'package:ava_light/accounts/providers/accounts_provider.dart';
import 'package:ava_light/accounts/widgets/accounts_list_card.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/credit_factors/providers/credit_factors_provider.dart';
import 'package:ava_light/credit_factors/widgets/credit_factors_list_widget.dart';
import 'package:ava_light/credit_score/providers/credit_score_provider.dart';
import 'package:ava_light/credit_score/widgets/credit_score_header.dart';
import 'package:ava_light/credit_score/widgets/credit_score_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(getAllAccountsProvider);
    final creditFactors = ref.watch(allCreditFactorsProvider);
    final latestReport = ref.watch(latestExperianReportProvider);

    final List<Widget> sections = [
      HomeSectionWidget(
        title: "Chart",
        children: [
          CreditScoreHomeWidget(),
        ],
      ),
      HomeSectionWidget(
        title: "Credit Factors",
        children: [
          CreditFactorsListWidget(factors: creditFactors),
        ],
      ),
      HomeSectionWidget(
        title: "Open Credit Card Accounts",
        children: [
          AccountsListCard(accounts: accounts),
        ],
      ),
    ];

    return Container(
      color: Color.fromRGBO(242, 240, 237, 1),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AvaColors.purple,
            foregroundColor: Colors.white,
            title: Text("Home"),
            bottom: PreferredSize(
              preferredSize: Size(0, 140),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 24,
                  top: 10,
                ),
                child: CreditScoreHeader(report: latestReport),
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings_outlined),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                return sections[index];
              },
            ),
          )
        ],
      ),
    );
  }
}

class HomeSectionWidget extends StatelessWidget {
  const HomeSectionWidget(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SpacedColumn(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: titleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          SpacedColumn(
            spacing: 34,
            children: children,
          )
        ],
      ),
    );
  }
}
