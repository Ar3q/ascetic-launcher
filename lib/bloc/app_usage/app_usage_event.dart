import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppUsageEvent extends Equatable {
  const AppUsageEvent();
}

class GetAppUsage extends AppUsageEvent {
  final DateTime startTime;
  final DateTime endTime;

  GetAppUsage({@required this.startTime, @required this.endTime});

  @override
  List<Object> get props => [startTime, endTime];
}
