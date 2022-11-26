import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final nombreDB = 'TAREASBD';
  static final versionBD = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, nombreDB);
    return await openDatabase(
      rutaDB,
      version: versionBD,
      onCreate: _crearTablas,
    );
  }

  _crearTablas(Database db, int version) async {
    String tblTareas =
        "CREATE TABLE tblTareas( idTarea INTEGER PRIMARY KEY, dscTarea VARCHAR(100), fechaEnt DATE)";
    String tblUser =
        "CREATE TABLE tblUser(idUser INTEGER PRIMARY KEY, fullName varchar(70), photo varchar(250), email varchar(70), phone varchar(10), githubPage varchar(70))";

    var tablas = [tblTareas, tblUser];
    tablas.forEach((sql) {
      db.execute(sql);
    });
  }
}
