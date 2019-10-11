import 'dart:async';
import 'package:ascetic_launcher/repositories/all_apps/all_apps_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class AllAppsBloc extends Bloc<AllAppsEvent, AllAppsState> {
  final AllAppsRepository allAppsRepository;

  AllAppsBloc({@required this.allAppsRepository})
      : assert(allAppsRepository != null);

  @override
  AllAppsState get initialState => InitialAllAppsState();

  @override
  Stream<AllAppsState> mapEventToState(
    AllAppsEvent event,
  ) async* {
    if (event is GetAllApps) {
      List<ApplicationWithIcon> allApps = await allAppsRepository.getAllApplications();
      yield AllAppsLoaded(allApps: allApps);
    } else if(event is SearchForApps) {
      yield FindingApps();
      List<ApplicationWithIcon> matchingApps = await allAppsRepository.getApplicationsWhithNameContainingPhrase(event.searchPhrase);
      yield AppsFound(matchingApps);
    }
  }
}
