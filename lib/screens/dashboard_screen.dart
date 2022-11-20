import 'package:clases/screens/theme_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
                      fit: BoxFit.cover)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIYjMIGljRAg5A-EE2DNc2B34kSTsNKDNMx2N5BtI8-oN4jQ0YXL3m4djdcwRA80dvE7k&usqp=CAU'),
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
