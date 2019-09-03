import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_list_item.dart';
import 'bloc/bloc.dart';

class AppsList extends StatefulWidget {
  final apps;
  final favoriteApps;
  final onUpdateFavoriteApps;

  const AppsList({this.onUpdateFavoriteApps, this.favoriteApps, this.apps});

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
      child: BlocBuilder<FavoriteAppsBloc, FavoriteAppsState>(
        bloc: favoriteAppsBloc,
        builder: (context, state) {
          if (state is FavoriteAppsLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.apps.length,
              itemBuilder: (context, i) => listItemBuilder(context, i, state.favoriteApps),
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

  Widget listItemBuilder(BuildContext context, int index, List<Application> favoriteApps) {
    final app = widget.apps[index];
    bool isFavoriteApp = false;
    for (var application in favoriteApps) {
      if(application.packageName == app.packageName) {
        isFavoriteApp = true;
      }
    }
    return AppListItem(
      app: app,
      isFavorite: isFavoriteApp,
      onFavoriteClicked: () async =>
          await onFavoriteClicked(context, app, isFavoriteApp),
    );
  }

  onFavoriteClicked(
      BuildContext context, Application app, bool isFavoriteApp) async {
    print(widget.favoriteApps);

    final favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);

    if (!isFavoriteApp) {
      favoriteAppsBloc.dispatch(AddToFavoriteApps(app));
    } else {
      favoriteAppsBloc.dispatch(DeleteFromFavoriteApps(app));
    }
  }

  removeFromFavoriteApps(Application app) async {
    List<String> updatedFavAppsList = List<String>();
    updatedFavAppsList = widget.favoriteApps;
    updatedFavAppsList.remove(app.packageName);

    await widget.onUpdateFavoriteApps(updatedFavAppsList);
  }

  addToFavoriteApps(Application app) async {
    if (widget.favoriteApps.length < 4) {
      List<String> updatedFavAppsList = List<String>();
      updatedFavAppsList = widget.favoriteApps;
      updatedFavAppsList.add(app.packageName);

      await widget.onUpdateFavoriteApps(updatedFavAppsList);
    } else {
      print('max 4 apps');
    }
  }
}
