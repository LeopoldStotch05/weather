import 'package:equatable/equatable.dart';

class HourlyWeatherModel extends Equatable {
  final String dt;
  final String temp;
  final String pressure;
  final String humidity;
  final String clouds;
  final String visibility;
  final String windSpeed;
  final String weatherDescription;
  final String weatherIcon;

  HourlyWeatherModel({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.weatherDescription,
    this.weatherIcon,
  });

  @override
  List<Object> get props => [
        dt,
        temp,
        pressure,
        humidity,
        clouds,
        visibility,
        windSpeed,
        weatherDescription,
        weatherIcon,
      ];
}
