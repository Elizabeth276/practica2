import 'package:clases/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tareas_model.dart';

class ListTaskScreen extends StatefulWidget {
  ListTaskScreen({Key? key}) : super(key: key);

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  TareasDAO? _tarea;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tarea = TareasDAO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add').then((value) {
                  setState(() {});
                });
              },
              icon: Icon(Icons.add_circle_outline))
        ],
      ),
      body: FutureBuilder(
        future: _tarea!.getAllTareas(),
        builder: (context, AsyncSnapshot<List<TareasDAO>> snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  height: MediaQuery.of(context).size.height * .15,
                  width: double.infinity,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data![index].fechaEnt!),
                        subtitle: Text(snapshot.data![index].dscTarea!),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/add', arguments: {
                                'idTarea': snapshot.data![index].idTarea,
                                'dscTarea': snapshot.data![index].dscTarea,
                                'fechEntrega': snapshot.data![index].fechaEnt,
                              }).then((value) {
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              var dialogo = AlertDialog(
                                title: Text('Importante!!'),
                                content: Text('¿Desea borrar esta tarea?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        _tarea!
                                            .eliminar(
                                                snapshot.data![index].idTarea!,
                                                'tblTareas')
                                            .then((value) {
                                          Navigator.pop(context);
                                          setState(() {});
                                        });
                                      },
                                      child: Text('Aceptar')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancelar'))
                                ],
                              );
                              showDialog(
                                  context: context, builder: (_) => dialogo);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10)),
                );
              },
              itemCount: snapshot.data!.length,
            );
          else if (snapshot.hasError)
            return Center(child: Text('Ocurrio un error en la petición'));

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
