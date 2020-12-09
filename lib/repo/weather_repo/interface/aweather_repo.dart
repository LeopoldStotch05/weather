import 'package:weather/repo/repository.dart';
import 'package:weather/request/weather_request/weather_request.dart';
import 'package:weather/response/weather_response/weather_response.dart';

abstract class AWeatherRepository extends Repository {
  Future<WeatherResponse> get weatherResponse;
  Future<WeatherResponse> getWeatherData(WeatherRequest requestModel);
  Future<bool> setWeatherToSharedPreferences(String key, WeatherResponse value);
  Future<WeatherResponse> getWeatherFromSharedPreferences(String key);
}
