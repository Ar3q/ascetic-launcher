import 'package:ascetic_launcher/bloc/weather_settings/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherSettingsSection extends StatelessWidget {
  final bool isEnabled;
  final String city;

  const WeatherSettingsSection({@required this.isEnabled, @required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SwitchListTile(
            title: Text('Current weather card visibility',),
            value: isEnabled,
            onChanged: (value) {
              BlocProvider.of<WeatherSettingsBloc>(context)
                  .dispatch(UpdateWeatherSettings(
                city: city,
                isWeatherCardEnabled: value,
              ));
            },
          ),
          Text('Current city for weather: $city'),
        ],
      ),
    );
  }
}
