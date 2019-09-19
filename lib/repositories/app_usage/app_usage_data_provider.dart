import 'package:app_usage/app_usage.dart';
import 'package:flutter/foundation.dart';

class AppUsageDataProvider {
  final AppUsage appUsage;

  AppUsageDataProvider({@required this.appUsage});

  Future<Map<String, double>> getUsageStats(
      {@required DateTime startTime, @required DateTime endTime}) async {
    Map<String, double> usage;

    try {
      usage = await appUsage.fetchUsage(startTime, endTime);
    } catch (e) {
      throw e;
    }
    usage.removeWhere((key, val) => val == 0);

    return usage;
  }
}
