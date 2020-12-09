import 'dart:async';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/units/main_screen/models/chart_model.dart';
import '../../../tools/tools.dart';
import '../models/current_weather_model.dart';
import '../models/daily_weather_model.dart';
import '../models/hourly_weather_model.dart';
import '../../../request/weather_request/weather_request.dart';
import '../../../response/weather_response/weather_response.dart';
import '../../../repo/weather_repo/interface/aweather_repo.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final AWeatherRepository weatherRepository;

  WeatherResponse _weatherResponse;

  final DateFormat _formatterYMMMMEEEEd = DateFormat.yMMMMEEEEd();
  final DateFormat _formatterHms = DateFormat.Hms();

  MainScreenBloc(this.weatherRepository) : super(null) {
    init();
  }

  void init() async {
    WeatherResponse weatherFromSP = await _getWeatherDataFromSP();

    if (weatherFromSP != null) {
      add(InitHourlyMainScreenEvent(weatherFromSP));
    }

    _weatherResponse = await _getWeatherData(50.4547, 30.5238);

    if (_weatherResponse != null) {
      weatherRepository.setWeatherToSharedPreferences(weaherSPKey, _weatherResponse);
      add(InitHourlyMainScreenEvent(_weatherResponse));
    }
  }

  Future<WeatherResponse> _getWeatherData(double lat, double lon) async {
    try {
      return await weatherRepository.getWeatherData(WeatherRequest(lat, lon, exclude: ['minutely'], units: 'metric'));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<WeatherResponse> _getWeatherDataFromSP() async {
    try {
      return await weatherRepository.weatherResponse;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Stream<MainScreenState> mapEventToState(
    MainScreenEvent event,
  ) async* {
    if (event is InitHourlyMainScreenEvent) {
      yield HourlyMainScreenState(
        getRegion(event.weatherResponse.timezone),
        _parseCurrentWeatherModel(event.weatherResponse.current),
        0,
        _parseHourlyWeatherModel(event.weatherResponse.hourly),
      );
    } else if (event is LoadHourlyMainScreenEvent) {
      yield HourlyMainScreenState(
        getRegion(_weatherResponse.timezone),
        _parseCurrentWeatherModel(_weatherResponse.current),
        event.index,
        _parseHourlyWeatherModel(_weatherResponse.hourly),
      );
    } else if (event is LoadDailyMainScreenEvent) {
      yield DailyMainScreenState(
        getRegion(_weatherResponse.timezone),
        _parseCurrentWeatherModel(_weatherResponse.current),
        event.index,
        _parseDailyWeatherModel(_weatherResponse.daily),
      );
    }
  }

  CurrentWeatherModel _parseCurrentWeatherModel(Current current) {
    assert(current != null);

    return CurrentWeatherModel(
      dt: current.dt != null ? _formatterYMMMMEEEEd.format(current.dt) : '',
      sunrise: current.sunrise != null ? _formatterHms.format(current.sunrise) : '',
      sunset: current.sunset != null ? _formatterHms.format(current.sunset) : '',
      temp: addSign(current.temp, '°C'),
      feelsLike: addSign(current.feelsLike, '°C'),
      pressure: addSign(current.pressure, ' hPa'),
      humidity: addSign(current.humidity, ' %'),
      dewPoint: addSign(current.dewPoint, '°C'),
      uvi: addSign(current.uvi),
      clouds: addSign(current.clouds, ' %'),
      visibility: addSign(current.visibility, ' m'),
      windSpeed: addSign(current.windSpeed, 'm/s'),
      windDeg: addSign(current.windDeg, '°'),
      weatherDescription: current.weather.first.description,
      weatherIcon: 'http://openweathermap.org/img/wn/${current.weather.first.icon}@2x.png',
    );
  }

  List<HourlyWeatherModel> _parseHourlyWeatherModel(List<Hourly> hourly) {
    assert(hourly != null);

    List<HourlyWeatherModel> list = [];

    hourly.forEach((Hourly element) {
      list.add(HourlyWeatherModel(
        dt: element.dt != null ? '${DateFormat.Hm().format(element.dt)} ${DateFormat.MMMEd().format(element.dt)}' : '',
        temp: addSign(element.temp, '°C'),
        pressure: addSign(element.pressure, ' hPa'),
        humidity: addSign(element.humidity, ' %'),
        clouds: addSign(element.clouds, ' %'),
        visibility: addSign(element.clouds, ' m'),
        windSpeed: addSign(element.windDeg, 'm/s'),
        weatherDescription: element.weather.first.description,
        weatherIcon: 'http://openweathermap.org/img/wn/${element.weather.first.icon}@2x.png',
      ));
    });

    return list;
  }

  List<DailyWeatherModel> _parseDailyWeatherModel(List<Daily> daily) {
    assert(daily != null);

    daily.asMap().keys;

    List<DailyWeatherModel> list = [];

    daily.forEach((Daily element) {
      list.add(DailyWeatherModel(
        dt: element.dt != null ? DateFormat.MMMEd().format(element.dt) : '',
        tempDay: addSign(element.temp.day, '°C'),
        tempNight: addSign(element.temp.day, '°C'),
        pressure: addSign(element.pressure, ' hPa'),
        humidity: addSign(element.humidity, ' %'),
        clouds: addSign(element.clouds, ' %'),
        windSpeed: addSign(element.windDeg, 'm/s'),
        weatherDescription: element.weather.first.description,
        weatherIcon: 'http://openweathermap.org/img/wn/${element.weather.first.icon}@2x.png',
      ));
    });

    return list;
  }
}
