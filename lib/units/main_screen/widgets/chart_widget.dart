/// Line chart example
import 'package:charts_flutter/flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PointsLineChart extends StatefulWidget {
  final List<LinearSales> seriesList;
  final bool animate;
  final void Function(DateTime) onTapCallback;

  PointsLineChart(this.seriesList, {this.animate, this.onTapCallback});

  @override
  _PointsLineChartState createState() => _PointsLineChartState();
}

class _PointsLineChartState extends State<PointsLineChart> {
  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      _createSampleData(widget.seriesList),
      defaultInteractions: true,
      animate: widget.animate,
      selectionModels: [
        SelectionModelConfig(
          type: SelectionModelType.info,
          changedListener: (data) => widget.onTapCallback(data.selectedDatum.first.datum.date),
        )
      ],
      behaviors: [
        LinePointHighlighter(
          showHorizontalFollowLine: LinePointHighlighterFollowLineType.none,
          showVerticalFollowLine: LinePointHighlighterFollowLineType.nearest,
        ),
        SelectNearest(eventTrigger: SelectionTrigger.tapAndDrag)
      ],
      primaryMeasureAxis: NumericAxisSpec(
        viewport: NumericExtents(
          widget.seriesList.reduce((curr, next) => curr.temp > next.temp ? curr : next).temp + 1,
          widget.seriesList.reduce((curr, next) => curr.temp < next.temp ? curr : next).temp - 1,
        ),
        showAxisLine: true,
        renderSpec: NoneRenderSpec(),
      ),
      defaultRenderer: LineRendererConfig(includePoints: true),
      domainAxis: DateTimeAxisSpec(
        showAxisLine: true,
        renderSpec: NoneRenderSpec(),
        viewport: DateTimeExtents(
          start: widget.seriesList.reduce((curr, next) => curr.date.isBefore(next.date) ? curr : next).date,
          end: widget.seriesList.reduce((curr, next) => curr.date.isAfter(next.date) ? curr : next).date,
        ),
      ),
    );
  }

  List<Series<LinearSales, DateTime>> _createSampleData(List<LinearSales> data) {
    return [
      Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        areaColorFn: (datum, index) => MaterialPalette.black.lighter,
        domainFn: (LinearSales sales, _) => sales.date,
        measureFn: (LinearSales sales, _) => sales.temp,
        data: data,
      )
    ];
  }
}

class LinearSales extends Equatable {
  final DateTime date;
  final double temp;

  LinearSales(this.date, this.temp);

  @override
  List<Object> get props => [date, temp];
}
