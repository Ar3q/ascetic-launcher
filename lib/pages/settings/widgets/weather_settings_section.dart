import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/bloc/weather_settings/bloc.dart';
import 'package:ascetic_launcher/pages/settings/widgets/text_with_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherSettingsSection extends StatefulWidget {
  final bool isEnabled;
  final String city;

  const WeatherSettingsSection({@required this.isEnabled, @required this.city});

  @override
  _WeatherSettingsSectionState createState() => _WeatherSettingsSectionState();
}

class _WeatherSettingsSectionState extends State<WeatherSettingsSection> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SwitchListTile(
          //   title: Text(
          //     'Current weather card visibility',
          //   ),
          //   value: widget.isEnabled,
          //   onChanged: (value) {
          // BlocProvider.of<WeatherSettingsBloc>(context)
          //     .dispatch(UpdateWeatherSettings(
          //   city: widget.city,
          //   isWeatherCardEnabled: value,
          // ));
          //   },
          // ),
          TextWithSwitch(
            initialSwitchValue: widget.isEnabled,
            onValueChanged: (bool value) {
              print('New value: $value');
              BlocProvider.of<WeatherSettingsBloc>(context)
                  .dispatch(UpdateWeatherSettings(
                city: widget.city,
                isWeatherCardEnabled: value,
              ));
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'City',
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: _controller,
                    onChanged: (text) {
                      BlocProvider.of<WeatherSettingsBloc>(context)
                          .dispatch(UpdateWeatherSettings(
                        city: text,
                        isWeatherCardEnabled: widget.isEnabled,
                      ));
                      BlocProvider.of<WeatherBloc>(context)
                          .dispatch(GetWeather(city: text));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
