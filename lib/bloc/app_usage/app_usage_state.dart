import 'package:ascetic_launcher/models/app_usage/application_with_time.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppUsageState extends Equatable {
  AppUsageState([List props = const <dynamic>[]]) : super(props);
}

class InitialAppUsageState extends AppUsageState {}

class LoadingAppUsageStats extends AppUsageState {}

class LoadedAppUsageStats extends AppUsageState {
  final List<ApplicationWithTime> usage;

  LoadedAppUsageStats({@required this.usage}) : super([usage]);
}

class ErrorWhileLoading extends AppUsageState {}