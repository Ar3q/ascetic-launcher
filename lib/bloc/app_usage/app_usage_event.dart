import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppUsageEvent extends Equatable {
  AppUsageEvent([List props = const <dynamic>[]]) : super(props);
}

class GetAppUsage extends AppUsageEvent {
  final DateTime startTime;
  final DateTime endTime;

  GetAppUsage({@required this.startTime, @required this.endTime})
      : super([startTime, endTime]);
}