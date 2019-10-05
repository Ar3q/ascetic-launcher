import 'package:ascetic_launcher/models/app_usage/application_with_time.dart';
import 'package:flutter/material.dart';

class AppUsageItem extends StatelessWidget {
  final ApplicationWithTime applicationWithTime;
  final EdgeInsetsGeometry margin;

  const AppUsageItem({@required this.applicationWithTime, this.margin})
      : assert(applicationWithTime != null);

  @override
  Widget build(BuildContext context) {
    int minutes = applicationWithTime.timeInMinutes;
    return Container(
      height: 50.0,
      margin: margin ??
          EdgeInsets.symmetric(
            vertical: 4.0,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  child: Image.memory(
                    applicationWithTime.application.icon,
                    // scale: 7.0,
                  ),
                ),
              ),
              Text(
                '${applicationWithTime.application.appName}',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${minutes.toString()} minutes',
            ),
          ),
        ],
      ),
    );
  }
}
