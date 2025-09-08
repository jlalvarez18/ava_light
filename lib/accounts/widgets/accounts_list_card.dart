import 'package:ava_light/accounts/models/account.dart';
import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/spaced_column.dart';
import 'package:ava_light/core/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

class _AccountWidgetState extends State<AccountWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.account.usagePercentage,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final percentFormatter = NumberFormat.percentPattern();
    final dateFormatter = DateFormat.yMMMMd();

    final titleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    final subtitleStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    final captionStyle = textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color.fromRGBO(115, 107, 124, 1),
    );

    return VisibilityDetector(
      key: Key(widget.account.uid),
      onVisibilityChanged: (info) {
        final visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage >= 90 && !_hasAnimated) {
          _hasAnimated = true;
          _animationController.forward();
        }
      },
      child: SpacedColumn(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.account.name, style: titleStyle),
              Text(
                percentFormatter.format(widget.account.usagePercentage),
                style: titleStyle,
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animation.value,
                minHeight: 8,
                borderRadius: BorderRadius.circular(999),
                valueColor: AlwaysStoppedAnimation(AvaColors.green),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.account.balance.toString(),
                style: subtitleStyle,
              ),
              Text(
                "${widget.account.limit.toString()} Limit",
                style: subtitleStyle,
              ),
            ],
          ),
          Text(
            "Reported on ${dateFormatter.format(widget.account.dateLastReported)}",
            style: captionStyle,
          ),
        ],
      ),
    );
  }
}
