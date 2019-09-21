import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatefulWidget {
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
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: searchController,
        onSubmitted: (text) {
          allAppsBloc.dispatch(SearchForApps(text));
        },
      ),
    );
  }
}