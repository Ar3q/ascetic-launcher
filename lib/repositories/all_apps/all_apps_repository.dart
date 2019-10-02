import 'package:ascetic_launcher/repositories/all_apps/all_apps_data_provider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

class AllAppsRepository {
  final AllAppsDataProvider allAppsDataProvider;

  AllAppsRepository({@required this.allAppsDataProvider})
      : assert(allAppsDataProvider != null);

  Future<List<Application>> getAllApplications() async {
    List<Application> allApps = await allAppsDataProvider.getAllApps();

    allApps.sort((a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));

    return allApps;
  }

  Future<List<Application>> getApplicationsWhithNameContainingPhrase(
      String searchedPhrase) async {
    List<Application> allApps = await getAllApplications();

    List<Application> matchingApps =
        allApps.where((app) => app.appName.toLowerCase().contains(searchedPhrase.toLowerCase())).toList();

    return matchingApps;
  }
}
