import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/units/main_screen/models/daily_weather_model.dart';
import 'package:weather/units/main_screen/models/hourly_weather_model.dart';

import '../widgets/chart_widget.dart';
import '../../../repo/weather_repo/interface/aweather_repo.dart';
import '../bloc/main_screen_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainScreenBloc _mainScreenBloc;
  final SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    _mainScreenBloc = MainScreenBloc(GetIt.instance.get<AWeatherRepository>(), _swiperController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 26.0, right: 16.0),
                  child: Column(
                    children: [
                      Expanded(child: _buildCurrentWeatherCard()),
                      Flexible(child: _buildSwiperWeather()),
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<MainScreenBloc, MainScreenState>(
                  cubit: _mainScreenBloc,
                  builder: (BuildContext context, MainScreenState state) {
                    if (state is HourlyMainScreenState) {
                      return PointsLineChart(
                        state.linearSales,
                        animate: true,
                        onTapCallback: (date) => _mainScreenBloc.add(TapOnChartHourlyMainScreenEvent(date)),
                      );
                    } else if (state is DailyMainScreenState) {
                      return PointsLineChart(
                        state.linearSales,
                        animate: true,
                        onTapCallback: (date) => _mainScreenBloc.add(TapOnChartDailyMainScreenEvent(date)),
                      );
                    } else {
                      return Center(child: Text('No data'));
                    }
                  },
                ),
              ),
            ],
          ),
          _buildToggleWeatherPeriodIconButton(),
        ],
      ),
    ));
  }

  Widget _buildCurrentWeatherCard() {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      cubit: _mainScreenBloc,
      builder: (BuildContext context, MainScreenState state) {
        if (state == null) {
          return Container();
        }

        List<Widget> list = [
          _buildAdditionalInfoWidget('Atmospheric pressure', state.currentWeather.pressure),
          _buildAdditionalInfoWidget('Humidity', state.currentWeather.humidity),
          _buildAdditionalInfoWidget('Atmospheric temperature', state.currentWeather.dewPoint),
          _buildAdditionalInfoWidget('Midday UV', state.currentWeather.uvi),
          _buildAdditionalInfoWidget('Cloudiness', state.currentWeather.clouds),
          _buildAdditionalInfoWidget('Average visibility', state.currentWeather.visibility),
          _buildAdditionalInfoWidget('Wind speed', state.currentWeather.windSpeed),
          _buildAdditionalInfoWidget('Wind direction', state.currentWeather.windDeg),
        ];

        return Column(
          children: [
            Center(
              child: Text(
                state.region,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(state.currentWeather.dt),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(state.currentWeather.weatherDescription),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: state.currentWeather.weatherIcon != null && state.currentWeather.weatherIcon.isNotEmpty
                        ? Image.network(state.currentWeather.weatherIcon, scale: 2, height: 50)
                        : Container(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.currentWeather.sunrise,
                        maxLines: 2,
                      ),
                      Text('Sunrise'),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    state.currentWeather.temp,
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        state.currentWeather.sunset,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                      ),
                      Text('Sunset', textAlign: TextAlign.end),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(state.currentWeather?.feelsLike != null ? 'Feels Like ${state.currentWeather.feelsLike}' : ''),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 6.0)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: list),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAdditionalInfoWidget(String description, String value) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Text(description),
          SizedBox(height: 4.0),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildToggleWeatherPeriodIconButton() {
    return Align(
      alignment: Alignment.topRight,
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        cubit: _mainScreenBloc,
        builder: (BuildContext context, MainScreenState state) {
          if (state is HourlyMainScreenState) {
            return CupertinoButton(
              child: Text('Hourly'),
              onPressed: () {
                _mainScreenBloc.add(LoadDailyMainScreenEvent());
              },
            );
          } else {
            return CupertinoButton(
              child: Text('Weekly'),
              onPressed: () {
                _mainScreenBloc.add(LoadHourlyMainScreenEvent());
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildSwiperWeather() {
    return Container(
      height: 260,
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        cubit: _mainScreenBloc,
        builder: (BuildContext context, MainScreenState state) {
          if (state == null) {
            return Center(child: Text('No data'));
          }

          return Swiper(
            loop: false,
            controller: _mainScreenBloc.swiperController,
            itemBuilder: (BuildContext context, int index) {
              if (state is HourlyMainScreenState) {
                return _buildswiperContainer(_buildHourlyCard(state.hourlyWeatherModelList[index]));
              } else if (state is DailyMainScreenState) {
                return _buildswiperContainer(_buildDailyCard(state.dailyWeatherModelList[index]));
              } else {
                return Center(child: Text('No data'));
              }
            },
            //TODO:change to method
            itemCount:
                state is HourlyMainScreenState ? state.hourlyWeatherModelList.length : (state as DailyMainScreenState).dailyWeatherModelList.length,
            pagination: SwiperPagination(builder: SwiperPagination.rect),
          );
        },
      ),
    );
  }

  Widget _buildswiperContainer(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF00022E),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildHourlyCard(HourlyWeatherModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.dt),
              Row(
                children: [
                  Text(model.weatherDescription),
                  model.weatherIcon != null && model.weatherIcon.isNotEmpty ? Image.network(model.weatherIcon, scale: 0.2, height: 60) : Container(),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              model.temp,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAdditionalInfoWidget('Atmospheric pressure', model.pressure),
              _buildAdditionalInfoWidget('Humidity', model.humidity),
              _buildAdditionalInfoWidget('Cloudiness', model.clouds),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAdditionalInfoWidget('Average visibility', model.visibility),
              _buildAdditionalInfoWidget('Wind speed', model.windSpeed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard(DailyWeatherModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.dt),
              Row(
                children: [
                  Text(model.weatherDescription),
                  model.weatherIcon != null && model.weatherIcon.isNotEmpty ? Image.network(model.weatherIcon, scale: 0.2, height: 60) : Container(),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Day ${model.tempDay}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Text(
                'Night ${model.tempNight}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAdditionalInfoWidget('Atmospheric pressure', model.pressure),
              _buildAdditionalInfoWidget('Humidity', model.humidity),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAdditionalInfoWidget('Cloudiness', model.clouds),
              _buildAdditionalInfoWidget('Wind speed', model.windSpeed),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mainScreenBloc.close();
    _swiperController.dispose();
    super.dispose();
  }
}
