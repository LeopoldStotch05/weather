import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../../../request/weather_request/weather_request.dart';
import '../../../repo/weather_repo/interface/aweather_repo.dart';
import '../../../response/weather_response/weather_response.dart';

class WeatherRepository extends AWeatherRepository {
  Future<WeatherResponse> _weatherResponse;

  Future<WeatherResponse> get weatherResponse => _weatherResponse;

  @override
  void init() {
    _weatherResponse = getWeatherFromSharedPreferences(weaherSPKey);
  }

  @override
  Future<WeatherResponse> getWeatherData(WeatherRequest requestModel) async {
    return WeatherResponse.fromJson(jsonDecode((await sendRequest(requestModel))?.data));
  }

  @override
  Future<bool> setWeatherToSharedPreferences(String key, WeatherResponse value) async {
    return (await SharedPreferences.getInstance()).setString(key, jsonEncode(value.toJson()));
  }

  @override
  Future<WeatherResponse> getWeatherFromSharedPreferences(String key) async {
    return WeatherResponse.fromJson(jsonDecode((await SharedPreferences.getInstance()).getString(key)));
  }
}
