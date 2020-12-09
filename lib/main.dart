import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'repo/weather_repo/interface/aweather_repo.dart';
import 'repo/weather_repo/repo/weather_repo.dart';
import 'request/request_controller.dart';

void main() {
  runApp(MyApp());

  _initInjector(GetIt.I);
}

void _initInjector(GetIt injector) {
  injector.registerSingleton<RequestController>(RequestController());
  injector.registerSingleton<AWeatherRepository>(WeatherRepository()..init());
}
