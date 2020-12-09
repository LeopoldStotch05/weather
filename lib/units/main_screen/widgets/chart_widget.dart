import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final Function(int) changeIndexCallback;

  const ChartWidget({
    @required this.minX,
    @required this.maxX,
    @required this.minY,
    @required this.maxY,
    this.changeIndexCallback,
    Key key,
  }) : super(key: key);
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.black26,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        minX: 0,
        maxX: 11,
        minY: -30,
        maxY: 70,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(color: Color(0xff68737d), fontSize: 10),
            getTitles: (value) {
              switch (value.toInt()) {
                case 2:
                  return 'MAR';
                case 5:
                  return 'JUN';
                case 8:
                  return 'SEP';
              }
              return '';
            },
            margin: 2,
          ),
          leftTitles: SideTitles(
            interval: 20,
            showTitles: true,
            getTextStyles: (value) => const TextStyle(color: Color(0xff67727d), fontSize: 10),
            getTitles: (value) {
              return value.toInt().toString();
            },
            reservedSize: 20,
            margin: 6,
          ),
        ),
        borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 32),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 3.1),
              FlSpot(8, 4),
              FlSpot(9.5, 3),
              FlSpot(11, 4),
            ],
            isCurved: true,
            colors: gradientColors,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
      ),
    );
  }
}
