import 'package:practica2/provider/theme_provider.dart';
import 'package:practica2/screens/list_task_screen.dart';
import 'package:practica2/screens/profile_screen.dart';
import 'package:practica2/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:practica2/screens/dashboard_screen.dart';
import 'package:practica2/screens/login_screen.dart';
import 'package:practica2/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema.getthemeData(),
      home: const SplashScreen(),
      routes: {
        '/dash': (BuildContext context) => DashboardScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/task': (BuildContext context) => ListTaskScreen(),
        '/add': (BuildContext context) => TaskScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
      },
    );
  }
}
