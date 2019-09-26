import 'package:ascetic_launcher/bloc/weather_settings/bloc.dart';
import 'package:ascetic_launcher/pages/settings/widgets/weather_settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      body: SafeArea(
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
                    style: TextStyle(fontSize: 50.0),
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
                      print('loaded');
                      return WeatherSettingsSection(
                        city: state.city,
                        isEnabled: state.isWeatherCardEnabled,
                      );
                    } else if (state is UpdatedWeatherSettingsState) {
                      print('updated');
                      return WeatherSettingsSection(
                        city: state.city,
                        isEnabled: state.isWeatherCardEnabled,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
