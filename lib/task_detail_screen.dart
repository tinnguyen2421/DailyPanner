import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskName;

  TaskDetailScreen({required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết công việc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              taskName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Thêm thông tin chi tiết công việc ở đây
            Text('Thông tin chi tiết công việc sẽ được hiển thị ở đây.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic chỉnh sửa công việc ở đây
              },
              child: Text('Chỉnh sửa công việc'),
            ),
          ],
        ),
      ),
    );
  }
}
