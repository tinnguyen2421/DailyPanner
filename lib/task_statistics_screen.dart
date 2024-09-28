import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TaskStatisticsScreen extends StatelessWidget {
  final List<TaskStat> data = [
    TaskStat('Hoàn thành', 10, Colors.green),
    TaskStat('Mới tạo', 5, Colors.blue),
    TaskStat('Đang thực hiện', 7, Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thống kê công việc')),
      body: Center(
        child: Container(
          child: SfCircularChart(
            series: <CircularSeries>[
              PieSeries<TaskStat, String>(
                dataSource: data,
                xValueMapper: (TaskStat stat, _) => stat.category,
                yValueMapper: (TaskStat stat, _) => stat.value,
                pointColorMapper: (TaskStat stat, _) => stat.color,
                dataLabelMapper: (TaskStat stat, _) => stat.category,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskStat {
  final String category;
  final int value;
  final Color color;

  TaskStat(this.category, this.value, this.color);
}

void main() {
  runApp(MaterialApp(
    home: TaskStatisticsScreen(),
  ));
}
