import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllAppsState extends Equatable {
  AllAppsState([List props = const <dynamic>[]]) : super(props);
}

class InitialAllAppsState extends AllAppsState {}

class AllAppsLoaded extends AllAppsState {
  final List<Application> allApps;

  AllAppsLoaded({this.allApps}) : super([allApps]);
}
