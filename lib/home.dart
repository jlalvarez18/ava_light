import 'package:ava_light/accounts/models/account.dart';
import 'package:ava_light/accounts/widgets/accounts_list_card.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/credit_factors/models/credit_factor.dart';
import 'package:ava_light/credit_factors/widgets/credit_factors_list_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<Account> accounts = [
    Account(
      uid: "Amazon Credit Card",
      dateAdded: DateTime(2023, 6, 20),
      name: "Amazon Credit Card",
      balanceInCents: 120000,
      limitInCents: 900000,
      dateLastReported: DateTime(2024, 6, 24),
    ),
    Account(
      uid: "Capital One Quicksilver",
      dateAdded: DateTime(2023, 6, 21),
      name: "Capital One Quicksilver",
      balanceInCents: 200000,
      limitInCents: 1000000,
      dateLastReported: DateTime(2024, 6, 24),
    ),
    Account(
      uid: "Apple Card",
      dateAdded: DateTime(2023, 6, 23),
      name: "Apple Card",
      balanceInCents: 200000,
      limitInCents: 500000,
      dateLastReported: DateTime(2024, 6, 24),
    ),
  ];

  final List<CreditFactor> creditFactors = [
    CreditFactor(
      title: "Payment History",
      value: "100%",
      impact: CreditImpact.high,
    ),
    CreditFactor(
      title: "Credit Card Utilization",
      value: "4%",
      impact: CreditImpact.low,
    ),
    CreditFactor(
      title: "Deragatory Marks",
      value: "2",
      impact: CreditImpact.medium,
    ),
    CreditFactor(
      title: "Age of Credit History",
      value: "1yr 4mo",
      impact: CreditImpact.low,
    ),
    CreditFactor(
      title: "Hard Inquiries",
      value: "3",
      impact: CreditImpact.medium,
    ),
    CreditFactor(
      title: "Total Accounts",
      value: "9",
      impact: CreditImpact.medium,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
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
            pinned: true,
            expandedHeight: 100,
            backgroundColor: AvaColors.purple,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Home"),
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
