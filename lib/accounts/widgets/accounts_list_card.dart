import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:ava_light/accounts/models/account.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/core/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountsListCard extends StatelessWidget {
  const AccountsListCard({super.key, required this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final account = accounts[index];

          return AccountWidget(account: account);
        },
        separatorBuilder: (context, index) => Divider(
          height: 40,
          thickness: 1,
          color: Colors.black12,
        ),
        itemCount: accounts.length,
      ),
    );
  }
}

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key, required this.account});

  final Account account;

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> with AfterLayoutMixin {
  double progressValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final percentFormatter = NumberFormat.percentPattern();
    final dateFormatter = DateFormat.yMMMMd();

    return SpacedColumn(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.account.name, style: textTheme.titleLarge),
            Text(percentFormatter.format(widget.account.usagePercentage),
                style: textTheme.titleLarge),
          ],
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: widget.account.usagePercentage),
          duration: Duration(seconds: 1),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              minHeight: 8,
              borderRadius: BorderRadius.circular(999),
              valueColor: AlwaysStoppedAnimation(AvaColors.green),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.account.balance.toString(),
                style: textTheme.titleMedium),
            Text("${widget.account.limit.toString()} Limit",
                style: textTheme.titleMedium),
          ],
        ),
        Text(
          "Reported on ${dateFormatter.format(widget.account.dateLastReported)}",
          style: textTheme.labelSmall,
        ),
      ],
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // setState(() {
    //   progressValue = widget.account.usagePercentage;
    // });
  }
}
