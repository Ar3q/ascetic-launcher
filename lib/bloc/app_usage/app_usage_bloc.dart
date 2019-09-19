import 'dart:async';
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
      Map<String, double> stats;
      try {
        print(event.startTime.toString());
        print(event.endTime.toString());
        stats = await appUsageRepository.getAllAppUsageStats(startDate: event.startTime, endDate: event.endTime);
      } catch (e) {
        print(e);
        yield ErrorWhileLoading();
      }
      print(stats.toString());
      yield LoadedAppUsageStats(usage: stats);
    }
  }
}
