import 'package:flutter/material.dart';

class DockElement extends StatelessWidget {
  final IconData iconData;
  final Function onClicked;

  const DockElement({@required this.iconData, this.onClicked})
      : assert(iconData != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (onClicked != null) {
          await onClicked();
        }
      },
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          iconData,
          size: 25.0,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
