import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _contentController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.task['content']);
    _timeController = TextEditingController(text: widget.task['time']);
    _locationController = TextEditingController(text: widget.task['location']);
    _noteController = TextEditingController(text: widget.task['note']);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    final editedTask = {
      'content': _contentController.text,
      'time': _timeController.text,
      'location': _locationController.text,
      'note': _noteController.text,
      'day': widget.task['day'], // Đảm bảo giữ nguyên ngày
    };

    Navigator.pop(context, editedTask); // Trả về công việc đã chỉnh sửa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chỉnh sửa công việc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Thời gian'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Địa điểm'),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Ghi chú'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
