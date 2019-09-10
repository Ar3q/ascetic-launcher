import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_list_item.dart';
import 'bloc/favorite_apps/bloc.dart';

class AppsList extends StatefulWidget {
  final apps;

  const AppsList({this.apps});

  @override
  _AppsListState createState() => _AppsListState();
}

class _AppsListState extends State<AppsList> {
  FavoriteAppsBloc favoriteAppsBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);
    });

    favoriteAppsBloc.dispatch(GetFavoriteApps());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO problem with flashing icons
      child: BlocBuilder<FavoriteAppsBloc, FavoriteAppsState>(
        bloc: favoriteAppsBloc,
        builder: (context, state) {
          if (state is FavoriteAppsLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.apps.length,
              itemBuilder: (context, i) =>
                  listItemBuilder(context, i),
              separatorBuilder: (context, i) => Divider(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget listItemBuilder(
      BuildContext context, int index) {
    final app = widget.apps[index];
    return AppListItem(
      app: app,
    );
  }
}
