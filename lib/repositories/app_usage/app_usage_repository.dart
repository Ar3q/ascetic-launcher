import 'package:ascetic_launcher/models/app_usage/application_with_time.dart';
import 'package:ascetic_launcher/repositories/app_usage/app_usage_data_provider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

class AppUsageRepository {
  final AppUsageDataProvider appUsageDataProvider;

  AppUsageRepository({@required this.appUsageDataProvider})
      : assert(appUsageDataProvider != null);

  Future<List<ApplicationWithTime>> getAllAppUsageStats({
    @required DateTime startDate,
    @required DateTime endDate,
    bool skipRecordsWithNoTime = true,
  }) async {
    Map<String, double> usageStats = await appUsageDataProvider.getUsageStats(
        startTime: startDate, endTime: endDate);

    usageStats.updateAll((key, val) => (val / 60).roundToDouble());

    if (skipRecordsWithNoTime) {
      usageStats.removeWhere((key, val) => val == 0);
    }

    List<ApplicationWithTime> list =
        await _transformToListWithApplicationWithTimeInMinutes(usageStats);

    return list;
  }

  Future<List<ApplicationWithTime>> getAppsUsageStatsForSpecifiedNumberOfApps({
    @required DateTime startDate,
    @required DateTime endDate,
    @required int lengthOfList,
    bool skipRecordsWithNoTime = true,
    bool descendingOrderByTime = true,
  }) async {
    List<ApplicationWithTime> list = await getAllAppUsageStats(
      startDate: startDate,
      endDate: endDate,
    );

    if (descendingOrderByTime) {
      list.sort((a, b) => b.timeInMinutes.compareTo(a.timeInMinutes));
    }

    List<ApplicationWithTime> shortenedList = list.take(lengthOfList).toList();

    return shortenedList;
  }

  Future<List<ApplicationWithTime>>
      _transformToListWithApplicationWithTimeInMinutes(
          Map<String, double> usageMap) async {
    List<ApplicationWithTime> list = List<ApplicationWithTime>();
    List<String> keys = usageMap.keys.toList();

    await Future.forEach(keys, (key) async {
      ApplicationWithIcon app;
      try {
        app = await DeviceApps.getApp(key, true);
      } catch (e) {
        print(e);
      }
      if (app != null) {
        ApplicationWithTime applicationWithTime = ApplicationWithTime(
          application: app,
          timeInMinutes: usageMap[key].toInt(),
        );
        list.add(applicationWithTime);
      }
    });

    return list;
  }
}
