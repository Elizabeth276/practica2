import 'package:clases/database/database_helper.dart';

class TareasDAO {
  int? idTarea;
  String? dscTarea;
  String? fechaEnt;
  DatabaseHelper? _db;

  TareasDAO({this.idTarea, this.dscTarea, this.fechaEnt});
  factory TareasDAO.fromJSON(Map<String, dynamic> mapTarea) {
    return TareasDAO(
      idTarea: mapTarea['idTarea'],
      dscTarea: mapTarea['dscTarea'],
      fechaEnt: mapTarea['fechaEnt'],
    );
  }

  Future<int> insertar(Map<String, dynamic> row, String nomTabla) async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    return await conexion.insert(nomTabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String nomTabla) async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    return await conexion.update(
      nomTabla,
      row,
      where: 'idTarea = ?',
      whereArgs: [row['idTarea']],
    );
  }

  Future<int> eliminar(int idTarea, String nomTabla) async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    return await conexion.delete(
      nomTabla,
      where: 'idTarea=?',
      whereArgs: [idTarea],
    );
  }

  Future<List<TareasDAO>> getAllTareas() async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    var result = await conexion.query('tblTareas');
    return result.map((mapTarea) => TareasDAO.fromJSON(mapTarea)).toList();
  }
}
