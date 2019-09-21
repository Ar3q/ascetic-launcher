import 'package:ascetic_launcher/bloc/app_usage/bloc.dart';
import 'package:ascetic_launcher/pages/your_section/app_usage/app_usage_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUsageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: BlocBuilder<AppUsageBloc, AppUsageState>(
        builder: (context, state) {
          if (state is InitialAppUsageState || state is LoadingAppUsageStats) {
            return CircularProgressIndicator();
          } else if (state is LoadedAppUsageStats) {
            return AppUsageList(
              stats: state.usage,
            );
          } else if (state is ErrorWhileLoading) {
            return Center(
              child: Text('Error occured'),
            );
          }
        },
      ),
    );
  }
}
