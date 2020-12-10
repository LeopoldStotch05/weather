part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

class InitHourlyMainScreenEvent extends MainScreenEvent {
  final WeatherResponse weatherResponse;

  InitHourlyMainScreenEvent(this.weatherResponse);

  @override
  List<Object> get props => [weatherResponse, ...super.props];
}

class LoadHourlyMainScreenEvent extends MainScreenEvent {
  LoadHourlyMainScreenEvent();
}

class LoadDailyMainScreenEvent extends MainScreenEvent {
  LoadDailyMainScreenEvent();
}

class TapOnChartHourlyMainScreenEvent extends MainScreenEvent {
  final DateTime selectedDateTime;
  TapOnChartHourlyMainScreenEvent(this.selectedDateTime);

  @override
  List<Object> get props => [selectedDateTime, ...super.props];
}

class TapOnChartDailyMainScreenEvent extends MainScreenEvent {
  final DateTime selectedDateTime;
  TapOnChartDailyMainScreenEvent(this.selectedDateTime);

  @override
  List<Object> get props => [selectedDateTime, ...super.props];
}
