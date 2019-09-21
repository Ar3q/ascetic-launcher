import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';

class ApplicationWithTime {
  final ApplicationWithIcon application;
  final int timeInMinutes;

  ApplicationWithTime(
      {@required this.application, @required this.timeInMinutes})
      : assert(application != null);
}
