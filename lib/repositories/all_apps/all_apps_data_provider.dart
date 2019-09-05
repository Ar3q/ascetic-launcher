import 'package:device_apps/device_apps.dart';

class AllAppsDataProvider {
  Future<List<Application>> getAllApps() async {
    List<Application> appList = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);
    
    return appList;
  }
}