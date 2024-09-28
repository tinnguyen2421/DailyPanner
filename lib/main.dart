import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // Đảm bảo bạn import đúng file chứa AppState
import 'welcome_screen.dart'; // Import màn hình chào

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: DailyPlannerApp(),
    ),
  );
}

class DailyPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(
        brightness: appState.isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: appState.isDarkMode ? Colors.grey[850] : Colors.blue,
        scaffoldBackgroundColor: appState.backgroundColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
              fontFamily: appState.fontFamily, color: appState.textColor),
          bodyLarge: TextStyle(
              fontFamily: appState.fontFamily, color: appState.textColor),
        ),
      ),
      home: WelcomeScreen(), // Bắt đầu bằng màn hình chào
    );
  }
}
