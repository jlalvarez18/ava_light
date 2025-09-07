import 'package:ava_light/core/app_config.dart';
import 'package:ava_light/user_info/models/employment_info.dart';
import 'package:ava_light/user_info/widgets/employment_information_details_widget.dart';
import 'package:ava_light/user_info/widgets/employment_information_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

class EmploymentInfomationPage extends StatefulWidget {
  const EmploymentInfomationPage({super.key});

  @override
  State<EmploymentInfomationPage> createState() =>
      _EmploymentInfomationPageState();
}

class _EmploymentInfomationPageState extends State<EmploymentInfomationPage> {
  bool isEditing = false;
  late EmploymentInfo info;

  @override
  void initState() {
    super.initState();

    info = EmploymentInfo(
      type: EmploymentType.fullTime,
      employerName: "Apple Inc",
      jobTitle: "Software engineer",
      grossAnnualIncome:
          Money.fromIntWithCurrency(21400000, AppConfig.currency),
      frequency: PayFrequency.biWeekly,
      nextPayDate: DateTime.now(),
      isDirectDeposit: true,
      employerAddress: "employerAddress",
      monthsEmployed: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Employment Information"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: isEditing
                      ? EmploymentInformationEditWidget()
                      : EmploymentInformationDetailsWidget(info: info),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: isEditing ? Text("Confirm") : Text("Edit"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
