import 'package:ascetic_launcher/models/app_usage/application_with_time.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppUsageState extends Equatable {
  const AppUsageState();
}

class InitialAppUsageState extends AppUsageState {
  @override
  List<Object> get props => null;
}

class LoadingAppUsageStats extends AppUsageState {
  @override
  List<Object> get props => null;
}

class LoadedAppUsageStats extends AppUsageState {
  final List<ApplicationWithTime> usage;

  LoadedAppUsageStats({@required this.usage});

  @override
  List<Object> get props => [usage];
}

class ErrorWhileLoading extends AppUsageState {
  @override
  List<Object> get props => null;
}
