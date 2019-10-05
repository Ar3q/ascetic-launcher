import 'package:flutter/material.dart';

class TextWithSwitch extends StatefulWidget {
  final bool initialSwitchValue;
  final Function onValueChanged;

  const TextWithSwitch(
      {@required this.initialSwitchValue, @required this.onValueChanged})
      : assert(onValueChanged != null);

  @override
  _TextWithSwitchState createState() => _TextWithSwitchState();
}

class _TextWithSwitchState extends State<TextWithSwitch> {
  bool switchValue;

  @override
  void initState() {
    super.initState();
    switchValue = widget.initialSwitchValue;
  }

  void onElementClick() {
    setState(() {
      switchValue = !switchValue;
    });
    widget.onValueChanged(switchValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          onElementClick();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Current weather card visibility',
              ),
            ),
            Switch(
              onChanged: (bool value) {
                onElementClick();
              },
              value: switchValue,
            )
          ],
        ),
      ),
    );
  }
}
