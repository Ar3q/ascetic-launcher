import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllAppsState extends Equatable {
  const AllAppsState();
}

class InitialAllAppsState extends AllAppsState {
  @override
  List<Object> get props => null;
}

class AllAppsLoaded extends AllAppsState {
  final List<ApplicationWithIcon> allApps;

  AllAppsLoaded({this.allApps});

  @override
  List<Object> get props => [allApps];
}

class FindingApps extends AllAppsState {
  @override
  List<Object> get props => null;
}

class AppsFound extends AllAppsState {
  final List<ApplicationWithIcon> foundApps;

  AppsFound(this.foundApps);

  @override
  List<Object> get props => [foundApps];
}
