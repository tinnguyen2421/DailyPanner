import 'package:flutter/material.dart';
import 'package:daily_planner_tinnguyen2421/task_list.dart';
import 'package:daily_planner_tinnguyen2421/calendar_view_screen.dart';
import 'package:daily_planner_tinnguyen2421/setting_screen.dart'; // Đảm bảo rằng SettingsScreen được import đúng

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình con
  static List<Widget> _widgetOptions = <Widget>[
    TaskListScreen(), // Màn hình danh sách công việc
    CalendarViewScreen(), // Màn hình lịch
    SettingsScreen(), // Màn hình cài đặt
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật chỉ mục khi người dùng bấm vào item
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions
          .elementAt(_selectedIndex), // Hiển thị màn hình tương ứng
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list), // Icon cho tab danh sách công việc
            label: 'Công việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Icon cho tab lịch
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Icon cho tab cài đặt
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _selectedIndex, // Vị trí hiện tại của chỉ mục
        selectedItemColor: Colors.blue, // Màu sắc khi item được chọn
        onTap: _onItemTapped, // Gọi hàm khi người dùng bấm vào item
      ),
    );
  }
}
