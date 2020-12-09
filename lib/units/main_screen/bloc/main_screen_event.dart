part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent extends Equatable {
  final int index;
  const MainScreenEvent(this.index);

  @override
  List<Object> get props => [index];
}

class InitHourlyMainScreenEvent extends MainScreenEvent {
  final WeatherResponse weatherResponse;

  InitHourlyMainScreenEvent(this.weatherResponse) : super(0);

  @override
  List<Object> get props => [weatherResponse, ...super.props];
}

class LoadHourlyMainScreenEvent extends MainScreenEvent {
  LoadHourlyMainScreenEvent(int index) : super(index);
}

class LoadDailyMainScreenEvent extends MainScreenEvent {
  LoadDailyMainScreenEvent(int index) : super(index);
}
