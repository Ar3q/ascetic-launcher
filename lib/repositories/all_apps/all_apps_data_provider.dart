import 'package:device_apps/device_apps.dart';

class AllAppsDataProvider {
  Future<List<ApplicationWithIcon>> getAllApps() async {
    List<dynamic> appList = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    // return appList as List<ApplicationWithIcon>;
    return List<ApplicationWithIcon>.from(appList);
  }
}
