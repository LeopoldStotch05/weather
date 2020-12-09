import 'package:equatable/equatable.dart';

class DailyWeatherModel extends Equatable {
  final String dt;
  final String tempDay;
  final String tempNight;
  final String pressure;
  final String humidity;
  final String clouds;
  final String windSpeed;
  final String weatherDescription;
  final String weatherIcon;

  DailyWeatherModel({
    this.dt,
    this.tempDay,
    this.tempNight,
    this.pressure,
    this.humidity,
    this.clouds,
    this.windSpeed,
    this.weatherDescription,
    this.weatherIcon,
  });

  @override
  List<Object> get props => [
        dt,
        tempDay,
        tempNight,
        pressure,
        humidity,
        windSpeed,
        weatherDescription,
        weatherIcon,
        clouds,
      ];
}
