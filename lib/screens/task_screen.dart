import 'package:clases/database/database_helper.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  DatabaseHelper? _database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFecha = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    final txtFechaEnt = TextField(controller: txtFecha);
    final txtDescTask = TextField(
      controller: txtDesc,
      maxLines: 8,
    );

    final btnGuardar = ElevatedButton(
      onPressed: () {
        _database!.insertar({
          'dscTarea': txtDesc.text,
          'fechaEnt': txtFecha.text,
        }, 'tblTareas');
      },
      child: Text('Guardar'),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: ListView(
        children: [
          txtFechaEnt,
          txtDescTask,
          btnGuardar,
        ],
      ),
    );
  }
}
