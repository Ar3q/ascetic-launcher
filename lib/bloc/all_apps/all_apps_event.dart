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

  SearchForApps(this.searchPhrase);

  @override
  List<Object> get props => [searchPhrase];
}
