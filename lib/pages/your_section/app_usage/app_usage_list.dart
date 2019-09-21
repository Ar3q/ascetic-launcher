import 'package:ascetic_launcher/models/app_usage/application_with_time.dart';
import 'package:ascetic_launcher/pages/your_section/app_usage/app_usage_item.dart';
import 'package:flutter/material.dart';

class AppUsageList extends StatelessWidget {
  final List<ApplicationWithTime> stats;

  const AppUsageList({@required this.stats}) : assert(stats != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: stats.length,
        itemBuilder: (BuildContext context, int index) {
          EdgeInsetsGeometry margin;
          if (index == 0) {
            margin = EdgeInsets.only(bottom: 4.0);
          } else if (index == stats.length - 1) {
            margin = EdgeInsets.only(top: 4.0);
          }
          return AppUsageItem(
            applicationWithTime: stats[index],
            margin: margin,
          );
        },
      ),
    );
  }
}
