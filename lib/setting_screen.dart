import 'package:daily_planner_tinnguyen2421/task_statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // Đảm bảo bạn import đúng file chứa AppState

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cài đặt')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cài đặt', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskStatisticsScreen()),
                  );
                },
                child: Text('Xem thống kê công việc'),
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text('Chế độ tối'),
                value: appState.isDarkMode,
                onChanged: (value) {
                  appState.toggleDarkMode();
                },
              ),
              SizedBox(height: 20),
              Text('Chọn màu nền', style: TextStyle(fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorPickerButton(
                    color: Colors.white,
                    onSelect: () {
                      appState.updateUI(Colors.white, appState.textColor,
                          appState.fontFamily);
                    },
                  ),
                  ColorPickerButton(
                    color: Colors.blue,
                    onSelect: () {
                      appState.updateUI(
                          Colors.blue, appState.textColor, appState.fontFamily);
                    },
                  ),
                  ColorPickerButton(
                    color: Colors.green,
                    onSelect: () {
                      appState.updateUI(Colors.green, appState.textColor,
                          appState.fontFamily);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Chọn phông chữ', style: TextStyle(fontSize: 18)),
              DropdownButton<String>(
                value: appState.fontFamily,
                items: <String>['Roboto', 'Arial', 'Times New Roman']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  appState.updateUI(
                      appState.backgroundColor, appState.textColor, newValue!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorPickerButton extends StatelessWidget {
  final Color color;
  final VoidCallback onSelect;

  ColorPickerButton({required this.color, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 40,
        height: 40,
        color: color,
        margin: EdgeInsets.all(8.0),
      ),
    );
  }
}
