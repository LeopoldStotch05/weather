part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenState extends Equatable {
  final String region;
  final CurrentWeatherModel currentWeather;
  final int index;

  const MainScreenState(this.region, this.currentWeather, this.index);

  @override
  List<Object> get props => [region, currentWeather];
}

class HourlyMainScreenState extends MainScreenState {
  final List<HourlyWeatherModel> hourlyWeatherModelList;
  HourlyMainScreenState(String region, CurrentWeatherModel currentWeather, int index, this.hourlyWeatherModelList)
      : super(region, currentWeather, index);

  @override
  List<Object> get props => [hourlyWeatherModelList, ...super.props];
}

class DailyMainScreenState extends MainScreenState {
  final List<DailyWeatherModel> dailyWeatherModelList;
  DailyMainScreenState(String region, CurrentWeatherModel currentWeather, int index, this.dailyWeatherModelList)
      : super(region, currentWeather, index);

  @override
  List<Object> get props => [dailyWeatherModelList, ...super.props];
}
