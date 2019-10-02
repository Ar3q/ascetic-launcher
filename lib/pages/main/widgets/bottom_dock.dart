import 'package:ascetic_launcher/pages/main/widgets/dock_element.dart';
import 'package:ascetic_launcher/utils/intent_utils.dart';
import 'package:flutter/material.dart';
import 'package:intent/action.dart' as Action;
import 'package:intent/category.dart';

class BottomDock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      // margin: EdgeInsets.symmetric(
      //   horizontal: 10.0,
      //   vertical: 10.0,
      // ),
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      padding: EdgeInsets.symmetric(
          // horizontal: 16.0,
          ),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(
            30.0,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DockElement(
            iconData: Icons.phone,
            onClicked: () {
              print('dialer');
              IntentUtils.useIntent(Action.Action.ACTION_DIAL);
            },
          ),
          DockElement(
            iconData: Icons.message,
            onClicked: () {
              print('messeges');
              IntentUtils.useIntentWithCategory(
                  Action.Action.ACTION_MAIN, Category.CATEGORY_APP_MESSAGING);
            },
          ),
          DockElement(
            iconData: Icons.email,
            onClicked: () {
              print('email');
              IntentUtils.useIntentWithCategory(
                  Action.Action.ACTION_MAIN, Category.CATEGORY_APP_EMAIL);
            },
          ),
          DockElement(
            iconData: Icons.language,
            onClicked: () {
              print('browser');
              IntentUtils.useIntentWithCategory(
                  Action.Action.ACTION_MAIN, Category.CATEGORY_APP_BROWSER);
            },
          ),
          DockElement(
            iconData: Icons.camera_alt,
            onClicked: () {
              print('camera');
              IntentUtils.useIntent(Action.Action.ACTION_IMAGE_CAPTURE);
            },
          ),
        ],
      ),
    );
  }
}
