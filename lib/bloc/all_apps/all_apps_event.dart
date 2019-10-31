import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllAppsEvent extends Equatable {
  const AllAppsEvent();
}

class GetAllApps extends AllAppsEvent {
  @override
  List<Object> get props => null;
}

class SearchForApps extends AllAppsEvent {
  final String searchPhrase;
  final List<Application> applications;

  SearchForApps(this.searchPhrase, this.applications);

  @override
  List<Object> get props => [searchPhrase, applications];
}
