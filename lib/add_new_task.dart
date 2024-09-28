import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTaskScreen extends StatefulWidget {
  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController taskContentController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime? selectedDate; // Biến để lưu ngày đã chọn

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm công việc mới')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => _selectDate(context), // Mở DatePicker khi nhấn
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Chọn ngày',
                    hintText: selectedDate != null
                        ? "${DateFormat('EEEE').format(selectedDate!)}, ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : 'Chưa chọn ngày',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: taskContentController,
              decoration: InputDecoration(labelText: 'Nội dung công việc'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeController,
              decoration:
                  InputDecoration(labelText: 'Thời gian (Ví dụ: 8h->11h)'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Địa điểm'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Ghi chú'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final String day = selectedDate != null
                    ? "${DateFormat('EEEE').format(selectedDate!)}, ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                    : "Chưa chọn";

                // Khi người dùng nhấn nút lưu
                Navigator.pop(context, {
                  'day': day,
                  'content': taskContentController.text,
                  'time': timeController.text,
                  'location': locationController.text,
                  'note': noteController.text,
                });
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
