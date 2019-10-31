import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatefulWidget {
  final List<Application> apps;

  const SearchField({@required this.apps});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AllAppsBloc allAppsBloc = BlocProvider.of<AllAppsBloc>(context);
    return Container(
      height: 50.0,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 12.0,
        right: 8.0,
        left: 8.0,
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColorLight,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 12.0,
          right: 16.0,
          left: 16.0,
          top: 12.0,
        ),
        child: TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          cursorColor: Theme.of(context).primaryColorDark,
          controller: searchController,
          onSubmitted: (text) {
            print(text);
            allAppsBloc.add(SearchForApps(text, widget.apps));
          },
        ),
      ),
    );
  }
}
