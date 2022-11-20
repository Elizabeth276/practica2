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
    final txtFechaEnt = TextField(
      controller: txtFecha,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
    final txtDescTask = TextField(
      controller: txtDesc,
      decoration: InputDecoration(border: OutlineInputBorder()),
      maxLines: 8,
    );

    final btnGuardar = ElevatedButton(
      onPressed: () {
        _database!.insertar({
          'dscTarea': txtDesc.text,
          'fechaEnt': txtFecha.text,
        }, 'tblTareas').then((value) {
          const snackBar = SnackBar(
            content: Text('¡Tarea registrada correctamente!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      child: Text('Guardar'),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        children: [
          txtFechaEnt,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: txtDescTask,
          ),
          btnGuardar,
        ],
      ),
    );
  }
}
