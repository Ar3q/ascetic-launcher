import 'package:ascetic_launcher/bloc/weather_settings/bloc.dart';
import 'package:ascetic_launcher/pages/settings/widgets/weather_settings_section.dart';
import 'package:ascetic_launcher/provider/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<WeatherSettingsBloc>(context)
    //     .dispatch(GetWeatherSettings());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    print(themeProvider.currentTheme);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SimpleGestureDetector(
          onHorizontalSwipe: (direction) {
            if (direction == SwipeDirection.left) {
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  child: Center(
                    child: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  child: BlocBuilder<WeatherSettingsBloc, WeatherSettingsState>(
                    builder: (context, state) {
                      print(state);
                      if (state is LoadingWeatherSettingsState) {
                        return Row(
                          children: <Widget>[
                            Text('Loading, please wait'),
                            SizedBox(
                              width: 10.0,
                            ),
                            CircularProgressIndicator(),
                          ],
                        );
                      } else if (state is LoadedWeatherSettingsState) {
                        return WeatherSettingsSection(
                          city: state.city,
                          isEnabled: state.isWeatherCardEnabled,
                        );
                      } else if (state is UpdatedWeatherSettingsState) {
                        return WeatherSettingsSection(
                          city: state.city,
                          isEnabled: state.isWeatherCardEnabled,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RadioButtonGroup(
                  labels: <String>['Grey', 'Green', 'Blue', 'Dark Grey'],
                  onSelected: (selected) {
                    switch (selected) {
                      case 'Grey':
                        themeProvider.changeCurrentTheme(MyThemesKeys.GREY);
                        break;
                      case 'Green':
                        themeProvider.changeCurrentTheme(MyThemesKeys.GREEN);
                        break;
                      case 'Blue':
                        themeProvider.changeCurrentTheme(MyThemesKeys.BLUE);
                        break;
                      case 'Dark Grey':
                        themeProvider
                            .changeCurrentTheme(MyThemesKeys.DARK_GREY);
                        break;
                      default:
                        themeProvider.changeCurrentTheme(MyThemesKeys.GREY);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
