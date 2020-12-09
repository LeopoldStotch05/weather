import 'package:equatable/equatable.dart';

class CurrentWeatherModel extends Equatable {
  final String dt;
  final String sunrise;
  final String sunset;
  final String temp;
  final String feelsLike;
  final String pressure;
  final String humidity;
  final String dewPoint;
  final String uvi;
  final String clouds;
  final String visibility;
  final String windSpeed;
  final String windDeg;
  final String weatherDescription;
  final String weatherIcon;

  CurrentWeatherModel({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weatherDescription,
    this.weatherIcon,
  });

  @override
  List<Object> get props => [
        dt,
        sunrise,
        sunset,
        temp,
        feelsLike,
        pressure,
        humidity,
        dewPoint,
        uvi,
        clouds,
        visibility,
        windSpeed,
        windDeg,
        weatherDescription,
        weatherIcon,
      ];
}
