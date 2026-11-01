import 'package:beu_codelab/core/utils/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class SubmissionHeatMapCalendar extends StatelessWidget {
  const SubmissionHeatMapCalendar({super.key, required this.dataSets});
  final Map<DateTime, int> dataSets;

  @override
  Widget build(BuildContext context) {
    const showLastDaysCount = 90;
    return HeatMap(
      defaultColor: Theme.of(context).canvasColor,
      colorMode: ColorMode.color,
      margin: const EdgeInsets.all(2),
      scrollable: true,
      startDate: DateTime.now()
          .subtract(const Duration(days: showLastDaysCount))
          .onlyDate,
      size: 18,
      datasets: dataSets,
      colorsets: const {
        1: Color(0xff026421),
        2: Color(0xff28C245),
        3: Color(0xff28C245),
        4: Color(0xff7EE08A),
      },
    );
  }
}
