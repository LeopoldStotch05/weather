import 'package:equatable/equatable.dart';

class ChartModel extends Equatable {
  final double temp;
  final double datetime;

  ChartModel(this.temp, this.datetime);

  @override
  List<Object> get props => [temp, datetime];
}
