import 'package:ascetic_launcher/repositories/all_apps/all_apps_data_provider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

class AllAppsRepository {
  final AllAppsDataProvider allAppsDataProvider;

  AllAppsRepository({@required this.allAppsDataProvider})
      : assert(allAppsDataProvider != null);

  Future<List<ApplicationWithIcon>> getAllApplications() async {
    List<ApplicationWithIcon> allApps = await allAppsDataProvider.getAllApps();

    allApps.sort(
        (a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));

    return allApps;
  }

  Future<List<ApplicationWithIcon>> getApplicationsWhithNameContainingPhrase(
      String searchedPhrase,
      [List<ApplicationWithIcon> allApplications]) async {
    List<ApplicationWithIcon> allApps =
        allApplications ?? await getAllApplications();

    List<ApplicationWithIcon> matchingApps = allApps
        .where((app) =>
            app.appName.toLowerCase().contains(searchedPhrase.toLowerCase()))
        .toList();

    return matchingApps;
  }
}
