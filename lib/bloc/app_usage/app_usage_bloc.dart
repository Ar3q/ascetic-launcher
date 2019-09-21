import 'dart:async';
import 'package:ascetic_launcher/models/app_usage/application_with_time.dart';
import 'package:ascetic_launcher/repositories/app_usage/app_usage_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class AppUsageBloc extends Bloc<AppUsageEvent, AppUsageState> {
  final AppUsageRepository appUsageRepository;

  AppUsageBloc({@required this.appUsageRepository});

  @override
  AppUsageState get initialState => InitialAppUsageState();

  @override
  Stream<AppUsageState> mapEventToState(
    AppUsageEvent event,
  ) async* {
    if (event is GetAppUsage) {
      yield LoadingAppUsageStats();
      List<ApplicationWithTime> stats;
      try {
        stats =
            await appUsageRepository.getAppsUsageStatsForSpecifiedNumberOfApps(
          startDate: event.startTime,
          endDate: event.endTime,
          lengthOfList: 5,
        );
        yield LoadedAppUsageStats(usage: stats);
      } catch (e) {
        yield ErrorWhileLoading();
      }
    }
  }
}
