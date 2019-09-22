import 'package:ascetic_launcher/bloc/favorite_apps/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppListItem extends StatefulWidget {
  final app;

  const AppListItem({Key key, this.app}) : super(key: key);

  @override
  _AppListItemState createState() => _AppListItemState();
}

class _AppListItemState extends State<AppListItem> {
  bool shouldBeStarShown;

  @override
  void initState() {
    super.initState();
    setState(() {
      shouldBeStarShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: GestureDetector(
        onTap: () {
          DeviceApps.openApp(widget.app.packageName);
        },
        onLongPress: () {
          setState(() {
            shouldBeStarShown = !shouldBeStarShown;
          });
        },
        child: BlocBuilder<FavoriteAppsBloc, FavoriteAppsState>(
          bloc: BlocProvider.of<FavoriteAppsBloc>(context),
          builder: (context, state) {
            if (state is FavoriteAppsLoaded) {
              return getItem(state.favoriteApps);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Container getItem(List<Application> favoriteApps) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.none,
                  child: Row(
                    children: <Widget>[
                      Text(
                        widget.app.appName.toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 50.0,
                child: Image.memory(
                  widget.app.icon,
                ),
              ),
            ),
          ),
          Visibility(
            visible: shouldBeStarShown,
            child: Expanded(
              child: GestureDetector(
                onTap: () {
                  onFavoriteClicked(isAppFavorite(favoriteApps));
                },
                child: Icon(
                  isAppFavorite(favoriteApps) ? Icons.star : Icons.star_border,
                  color: isAppFavorite(favoriteApps) ? Colors.yellow : null,
                  size: 35.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onFavoriteClicked(bool isFavorite) {
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
  }

  bool isAppFavorite(List<Application> favoriteApps) {
    for (var favApp in favoriteApps) {
      if (favApp.packageName == widget.app.packageName) {
        return true;
      }
    }
    return false;
  }
}
