import 'dart:io';
import 'package:practica2/screens/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:practica2/models/user_model.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  File? profileImage;
  String? path;
  UserDAO? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 226, 133, 26),
        child: ListView(children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images6.alphacoders.com/860/thumb-1920-860645.png'),
                    fit: BoxFit.cover),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Hero(
                  tag: 'profile_picture',
                  child: CircleAvatar(
                    backgroundImage: (path == null)
                        ? AssetImage('assets/profile.jpg')
                        : AssetImage(''),
                  ),
                ),
              ),
              accountName: Text('Elizabeth Villagómez',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              accountEmail: Text(
                '18031189@itcelaya.edu.mx',
                style: TextStyle(color: Colors.black),
              )),
          ListTile(
              leading: Image.asset('assets/hongo.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Práctica 1'),
              onTap: () {}),
          ListTile(
              leading: Image.asset('assets/hongo.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Base de datos'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              }),
          ListTile(
              leading: Image.asset('assets/hongo.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              })
        ]),
      ),
      body: ThemeScreen(),
    );
  }
}
