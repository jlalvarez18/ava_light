import 'package:ava_light/accounts/models/account.dart';
import 'package:ava_light/accounts/widgets/accounts_list_card.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
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

  @override
  Widget build(BuildContext context) {
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
              itemCount: 1,
              itemBuilder: (context, index) {
                return HomeSectionWidget(
                  title: "Open Credit Card Accounts",
                  children: [
                    AccountsListCard(accounts: accounts),
                  ],
                );
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

    return SpacedColumn(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textTheme.headlineMedium,
          textAlign: TextAlign.left,
        ),
        SpacedColumn(
          spacing: 34,
          children: children,
        )
      ],
    );
  }
}
