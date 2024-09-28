import 'package:daily_planner_tinnguyen2421/add_new_task.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'task_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarViewScreen extends StatefulWidget {
  @override
  _CalendarViewScreenState createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  DateTime selectedDay = DateTime.now();
  Map<DateTime, List<Map<String, dynamic>>> events = {};

  @override
  void initState() {
    super.initState();
    _loadEvents(); // Tải sự kiện từ Shared Preferences
  }

  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List<dynamic> tasksJson = jsonDecode(tasksString);
      for (var task in tasksJson) {
        DateTime date = DateTime.parse(task['day']);
        if (!events.containsKey(date)) {
          events[date] = [];
        }
        events[date]!.add(task); // Thêm công việc vào ngày tương ứng
      }
      setState(() {}); // Cập nhật giao diện
    }
  }

  Future<void> _addEvent(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              AddNewTaskScreen()), // Mở màn hình thêm công việc mới
    );

    if (result != null) {
      DateTime date = selectedDay;
      if (!events.containsKey(date)) {
        events[date] = [];
      }

      events[date]!.add({
        'day': date.toIso8601String(),
        'content': result['content'],
        'time': result['time'],
        'location': result['location'],
        'note': result['note'],
      });

      // Lưu vào Shared Preferences
      _saveEvents();

      setState(() {}); // Cập nhật giao diện
    }
  }

  Future<void> _saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> tasksToSave = [];
    events.forEach((date, tasks) {
      for (var task in tasks) {
        tasksToSave.add(task);
      }
    });
    await prefs.setString('tasks', jsonEncode(tasksToSave));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2025, 12, 31),
            focusedDay: selectedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            eventLoader: (day) {
              return events[day]?.map((e) => e['content']).toList() ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: Colors.red, // Màu sắc của dấu hiệu
                    ),
                  );
                }
                return SizedBox(); // Không hiển thị gì nếu không có sự kiện
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events[selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                Map<String, dynamic> event = events[selectedDay]![index];
                return ListTile(
                  title: Text(event['content']),
                  subtitle: Text(
                      'Thời gian: ${event['time']}, Địa điểm: ${event['location']}, Ghi chú: ${event['note']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TaskDetailScreen(taskName: event['content']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addEvent(context), // Thêm sự kiện
        child: Icon(Icons.add),
      ),
    );
  }
}
