import 'package:ascetic_launcher/repositories/app_usage/app_usage_data_provider.dart';
import 'package:flutter/foundation.dart';

class AppUsageRepository {
  final AppUsageDataProvider appUsageDataProvider;

  AppUsageRepository({@required this.appUsageDataProvider})
      : assert(appUsageDataProvider != null);

  Future<Map<String, double>> getAllAppUsageStats(
      {DateTime startDate, DateTime endDate}) async {
    Map<String, double> usageStats = await appUsageDataProvider.getUsageStats(
        startTime: startDate, endTime: endDate);
    
    usageStats.updateAll((key, val) => (val / 60).roundToDouble());

    return usageStats;
  }

}
