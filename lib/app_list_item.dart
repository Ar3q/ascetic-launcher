import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class AppListItem extends StatefulWidget {
  final app;
  final isFavorite;

  const AppListItem({this.app, this.isFavorite});

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
      child: GestureDetector(
        onTap: () {
          DeviceApps.openApp(widget.app.packageName);
        },
        onLongPress: () {
          setState(() {
            shouldBeStarShown = !shouldBeStarShown;
          });
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
                    // widget.onFavoriteClicked();
                    onFavoriteClicked();
                  },
                  child: Icon(
                    widget.isFavorite ? Icons.star : Icons.star_border,
                    color: widget.isFavorite ? Colors.yellow : null,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onFavoriteClicked() {
    final favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);

    if (widget.isFavorite) {
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
}
