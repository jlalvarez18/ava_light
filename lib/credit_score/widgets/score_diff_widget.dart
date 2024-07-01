import 'package:ava_light/core/theme/colors.dart';
import 'package:ava_light/core/ui/pill_widget.dart';
import 'package:ava_light/credit_score/providers/credit_score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreDiffWidget extends ConsumerWidget {
  const ScoreDiffWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diff = ref.watch(latestExperianScoreDiffProvider);

    String diffText;
    Color diffColor;
    if (diff >= 0) {
      diffText = "+${diff}pts";
      diffColor = AvaColors.green;
    } else {
      diffText = "${diff}pts";
      diffColor = AvaColors.darkRed;
    }

    return PillWidget(text: diffText, color: diffColor);
  }
}
