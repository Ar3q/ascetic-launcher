import 'package:ascetic_launcher/bloc/favorite_apps/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_list_item.dart';

class AppsList extends StatefulWidget {
  final apps;
  final bool scrollable;

  const AppsList({this.apps, this.scrollable = true});

  @override
  _AppsListState createState() => _AppsListState();
}

class _AppsListState extends State<AppsList> {
  FavoriteAppsBloc favoriteAppsBloc;
  ScrollController _scrollController;
  bool _shouldReturnToHomePage = false;

  @override
  void initState() {
    super.initState();
    favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);
    favoriteAppsBloc.dispatch(GetFavoriteApps());
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_shouldReturnToHomePage) {
        Navigator.pop(context);
      } else {
        _shouldReturnToHomePage = true;
      }
    }
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
              controller: _scrollController,
              physics: widget.scrollable
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.apps.length,
              itemBuilder: (context, i) {
                final app = widget.apps[i];
                return AppListItem(
                  app: app,
                );
              },
              separatorBuilder: (context, i) => SizedBox(),
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
}
