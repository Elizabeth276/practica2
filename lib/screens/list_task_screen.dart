import 'package:clases/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ListTaskScreen extends StatefulWidget {
  ListTaskScreen({Key? key}) : super(key: key);

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  DatabaseHelper? _database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              icon: Icon(Icons.add_circle_outline))
        ],
      ),
      body: FutureBuilder(
        future: _database!.getAllTareas(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Text('Aqui va el contenido');
          else if (snapshot.hasError)
            return Center(child: Text('Ocurrio un error en la petición'));

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
