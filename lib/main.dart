import 'package:clases/screens/list_task_screen.dart';
import 'package:clases/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:clases/screens/dashboard_screen.dart';
import 'package:clases/screens/login_screen.dart';
import 'package:clases/screens/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
      routes: {
        '/dash': (BuildContext context) => DashboardScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/task': (BuildContext context) => ListTaskScreen(),
        '/add': (BuildContext context) => TaskScreen(),
      },
    );
  }
}
