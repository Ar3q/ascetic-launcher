import 'package:flutter/material.dart';

class AppUsageList extends StatelessWidget {
  final Map<String, double> stats;

  const AppUsageList({@required this.stats}) : assert(stats != null);

  @override
  Widget build(BuildContext context) {
    List<String> keys = stats.keys.toList();
    return Container(
      child: ListView.builder(
        itemCount: stats.length,
        itemBuilder: (BuildContext context, int index) {
          double minutes = stats[keys[index]];
          return Container(
            child: Row(
              children: <Widget>[
                Text('${keys[index]}'),
                Text('Time: ${minutes.toString()} minutes'),
              ],
            ),
          );
        },
      ),
    );
  }
}
