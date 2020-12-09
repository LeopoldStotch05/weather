import 'package:equatable/equatable.dart';

class WeatherResponse extends Equatable {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;
  final List<Hourly> hourly;
  final List<Daily> daily;

  WeatherResponse({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.hourly,
    this.daily,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    List<Hourly> hourlyList = [];
    List<Daily> dailyList = [];

    if (json['hourly'] != null) {
      json['hourly'].forEach((v) => hourlyList.add(Hourly.fromJson(v)));
    }

    if (json['daily'] != null) {
      json['daily'].forEach((v) => dailyList.add(Daily.fromJson(v)));
    }

    return WeatherResponse(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: json['current'] != null ? Current.fromJson(json['current']) : null,
      hourly: hourlyList,
      daily: dailyList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['timezone_offset'] = timezoneOffset;
    if (current != null) {
      data['current'] = current.toJson();
    }
    if (hourly != null) {
      data['hourly'] = hourly.map((v) => v.toJson()).toList();
    }
    if (daily != null) {
      data['daily'] = daily.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object> get props => [
        lat,
        lon,
        timezone,
        timezoneOffset,
        current,
        hourly,
        daily,
      ];
}

class Current extends Equatable {
  final DateTime dt;
  final DateTime sunrise;
  final DateTime sunset;
  final double temp;
  final double feelsLike;
  final double pressure;
  final double humidity;
  final double dewPoint;
  final double uvi;
  final double clouds;
  final double visibility;
  final double windSpeed;
  final double windDeg;
  final List<Weather> weather;

  Current({
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
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    List<Weather> weatherList = [];

    if (json['weather'] != null) {
      json['weather'].forEach((v) => weatherList.add(Weather.fromJson(v)));
    }

    return Current(
      dt: json['dt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000) : null,
      sunrise: json['sunrise'] != null ? DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000) : null,
      sunset: json['sunset'] != null ? DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000) : null,
      temp: json['temp']?.toDouble(),
      feelsLike: json['feels_like']?.toDouble(),
      pressure: json['pressure']?.toDouble(),
      humidity: json['humidity']?.toDouble(),
      dewPoint: json['dew_point']?.toDouble(),
      uvi: json['uvi']?.toDouble(),
      clouds: json['clouds']?.toDouble(),
      visibility: json['visibility']?.toDouble(),
      windSpeed: json['wind_speed']?.toDouble(),
      windDeg: json['wind_deg']?.toDouble(),
      weather: weatherList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dt'] = dt != null ? dt.millisecondsSinceEpoch ~/ 1000 : null;
    data['sunrise'] = sunrise != null ? sunrise.millisecondsSinceEpoch ~/ 1000 : null;
    data['sunset'] = sunset != null ? sunset.millisecondsSinceEpoch ~/ 1000 : null;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['uvi'] = uvi;
    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    return data;
  }

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
        weather,
      ];
}

class Weather extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }

  @override
  List<Object> get props => [id, main, description, icon];
}

class Hourly extends Equatable {
  final DateTime dt;
  final double temp;
  final double feelsLike;
  final double pressure;
  final double humidity;
  final double dewPoint;
  final double uvi;
  final double clouds;
  final double visibility;
  final double windSpeed;
  final double windDeg;
  final List<Weather> weather;
  final double pop;

  Hourly({
    this.dt,
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
    this.weather,
    this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    List<Weather> weatherList = [];

    if (json['weather'] != null) {
      json['weather'].forEach((v) => weatherList.add(Weather.fromJson(v)));
    }

    return Hourly(
      dt: json['dt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000) : null,
      temp: json['temp']?.toDouble(),
      feelsLike: json['feels_like']?.toDouble(),
      pressure: json['pressure']?.toDouble(),
      humidity: json['humidity']?.toDouble(),
      dewPoint: json['dew_point']?.toDouble(),
      uvi: json['uvi']?.toDouble(),
      clouds: json['clouds']?.toDouble(),
      visibility: json['visibility']?.toDouble(),
      windSpeed: json['wind_speed']?.toDouble(),
      windDeg: json['wind_deg']?.toDouble(),
      weather: weatherList,
      pop: json['pop']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dt'] = dt != null ? dt.millisecondsSinceEpoch ~/ 1000 : null;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['uvi'] = uvi;
    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    data['pop'] = pop;

    return data;
  }

  @override
  List<Object> get props => [
        dt,
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
        weather,
        pop,
      ];
}

class Daily extends Equatable {
  final DateTime dt;
  final DateTime sunrise;
  final DateTime sunset;
  final Temp temp;
  final double pressure;
  final double humidity;
  final double dewPoint;
  final double windSpeed;
  final double windDeg;
  final List<Weather> weather;
  final double clouds;
  final double pop;
  final double uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    List<Weather> weatherList = [];

    if (json['weather'] != null) {
      json['weather'].forEach((v) => weatherList.add(Weather.fromJson(v)));
    }

    return Daily(
      dt: json['dt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000) : null,
      sunrise: json['sunrise'] != null ? DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000) : null,
      sunset: json['sunset'] != null ? DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000) : null,
      temp: json['temp'] != null ? Temp.fromJson(json['temp']) : null,
      pressure: json['pressure']?.toDouble(),
      humidity: json['humidity']?.toDouble(),
      dewPoint: json['dew_point']?.toDouble(),
      windSpeed: json['wind_speed']?.toDouble(),
      windDeg: json['wind_deg']?.toDouble(),
      weather: weatherList,
      clouds: json['clouds']?.toDouble(),
      pop: json['pop']?.toDouble(),
      uvi: json['uvi']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dt'] = dt != null ? dt.millisecondsSinceEpoch ~/ 1000 : null;
    data['sunrise'] = sunrise != null ? sunrise.millisecondsSinceEpoch ~/ 1000 : null;
    data['sunset'] = sunset != null ? sunset.millisecondsSinceEpoch ~/ 1000 : null;
    if (temp != null) {
      data['temp'] = temp.toJson();
    }

    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['uvi'] = uvi;
    return data;
  }

  @override
  List<Object> get props => [
        dt,
        sunrise,
        sunset,
        temp,
        pressure,
        humidity,
        dewPoint,
        windSpeed,
        windDeg,
        weather,
        clouds,
        pop,
        uvi,
      ];
}

class Temp extends Equatable {
  final double day;
  final double night;

  Temp({this.day, this.night});

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day']?.toDouble(),
      night: json['night']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['day'] = day;
    data['night'] = night;
    return data;
  }

  @override
  List<Object> get props => [day, night];
}
