import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorite_apps/bloc.dart';

class AppListItem extends StatefulWidget {
  final app;

  const AppListItem({Key key, this.app}) : super(key: key);

  @override
  _AppListItemState createState() => _AppListItemState();
}

class _AppListItemState extends State<AppListItem> {
  bool shouldBeStarShown;
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    setState(() {
      shouldBeStarShown = false;
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: GestureDetector(
        onTap: () {
          DeviceApps.openApp(widget.app.packageName);
        },
        onLongPress: () {
          setState(() {
            shouldBeStarShown = !shouldBeStarShown;
          });
        },
        child: BlocListener<FavoriteAppsBloc, FavoriteAppsState>(
          bloc: BlocProvider.of<FavoriteAppsBloc>(context),
          listener: (context, state) {
            if (state is FavoriteAppsLoaded) {
              print('before ' + isFavorite.toString());
              setState(() {
                isFavorite = isAppFavorite(state.favoriteApps);
              });
              print('after ' + isFavorite.toString());
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  widget.app.appName.toString(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.memory(widget.app.icon),
              ),
              Visibility(
                visible: shouldBeStarShown,
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('fav');
                      onFavoriteClicked();
                    },
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : null,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
              // child: Expanded(
              //   child: GestureDetector(
              //     onTap: () {
              //       print('fav');
              //       onFavoriteClicked();
              //     },
              //     child: Icon(
              //       isFavorite ? Icons.star : Icons.star_border,
              //       color: isFavorite ? Colors.yellow : null,
              //       size: 35.0,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void onFavoriteClicked() {
    final favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);

    if (isFavorite) {
      //remove
      favoriteAppsBloc.dispatch(DeleteFromFavoriteApps(widget.app));
      setState(() {
        shouldBeStarShown = false;
      });
    } else {
      //add
      favoriteAppsBloc.dispatch(AddToFavoriteApps(widget.app));
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  bool isAppFavorite(List<Application> favoriteApps) {
    for (var favApp in favoriteApps) {
      if (favApp.packageName == widget.app.packageName) {
        print('the same ' + favApp.packageName + ' ' + widget.app.packageName);
        return true;
      }
    }
    print('not the same');
    return false;
  }
}
