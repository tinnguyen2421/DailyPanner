import 'package:daily_planner_tinnguyen2421/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Để chuyển đổi JSON
import 'add_new_task.dart'; // Import màn hình thêm công việc mới

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Map<DateTime, List<Map<String, dynamic>>> events =
      {}; // Dữ liệu công việc theo ngày

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Tải các công việc từ Shared Preferences
  }

  // Hàm tải công việc từ SharedPreferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List<dynamic> tasksJson = jsonDecode(tasksString);
      for (var task in tasksJson) {
        DateTime date = DateTime.parse(task['day']);
        if (!events.containsKey(date)) {
          events[date] = [];
        }
        events[date]!.add(task);
      }
      setState(() {});
    }
  }

  // Hàm lưu công việc vào SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> tasksToSave = [];
    events.forEach((date, tasks) {
      for (var task in tasks) {
        tasksToSave.add(task);
      }
    });
    await prefs.setString('tasks', jsonEncode(tasksToSave));
  }

  // Hàm thêm công việc mới
  void _addNewTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );

    if (newTask != null) {
      DateTime date = DateTime.parse(newTask['day']);
      if (!events.containsKey(date)) {
        events[date] = [];
      }

      setState(() {
        events[date]!.add(newTask);
      });

      _saveTasks(); // Lưu công việc sau khi thêm mới
    }
  }

  // Hàm sửa công việc
  void _editTask(DateTime date, int index) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: events[date]![index]),
      ),
    );

    if (editedTask != null) {
      setState(() {
        events[date]![index] = editedTask; // Cập nhật công việc đã sửa
      });

      _saveTasks(); // Lưu lại sau khi sửa
    }
  }

  // Hàm xóa công việc
  void _deleteTask(DateTime date, int index) {
    setState(() {
      events[date]!.removeAt(index); // Xóa công việc
      if (events[date]!.isEmpty) {
        events.remove(date); // Xóa ngày nếu không còn công việc nào
      }
    });

    _saveTasks(); // Lưu lại sau khi xóa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách công việc')),
      body: ListView(
        children: events.entries.map((entry) {
          DateTime date = entry.key;
          List<Map<String, dynamic>> tasksForDate = entry.value;

          return ExpansionTile(
            key: ValueKey(date),
            title: Text(
              'Ngày: ${date.day}/${date.month}/${date.year}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              // Danh sách công việc có thể kéo thả
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: tasksForDate.asMap().entries.map((taskEntry) {
                  int index = taskEntry.key;
                  Map<String, dynamic> task = taskEntry.value;

                  return ListTile(
                    key: ValueKey(task['content']),
                    title: Text(task['content'] ?? ''),
                    subtitle: Text(
                      'Thời gian: ${task['time'] ?? ''}, Địa điểm: ${task['location'] ?? ''}, Ghi chú: ${task['note'] ?? ''}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              _editTask(date, index), // Chỉnh sửa công việc
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              _deleteTask(date, index), // Xóa công việc
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex--;
                  setState(() {
                    var movedTask = tasksForDate.removeAt(oldIndex);
                    tasksForDate.insert(newIndex, movedTask);
                    _saveTasks(); // Cập nhật thứ tự trong SharedPreferences
                  });
                },
              ),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
