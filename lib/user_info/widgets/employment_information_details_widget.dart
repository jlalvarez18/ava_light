import 'package:ava_light/user_info/models/employment_info.dart';
import 'package:flutter/material.dart';

class EmploymentInformationDetailsWidget extends StatefulWidget {
  const EmploymentInformationDetailsWidget({super.key, required this.info});

  final EmploymentInfo info;

  @override
  State<EmploymentInformationDetailsWidget> createState() =>
      _EmploymentInformationDetailsWidgetState();
}

class _EmploymentInformationDetailsWidgetState
    extends State<EmploymentInformationDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Details"),
    );
  }
}
