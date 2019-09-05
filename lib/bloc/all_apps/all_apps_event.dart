import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllAppsEvent extends Equatable {
  AllAppsEvent([List props = const <dynamic>[]]) : super(props);
}

class GetAllApps extends AllAppsEvent {
}
