import 'package:practica2/database/database_helper.dart';
import 'package:flutter/material.dart';

class UserDAO {
  int? idUser;
  String? fullName;
  String? photo;
  String? email;
  String? phone;
  String? githubPage;
  DatabaseHelper? _db;

  UserDAO(
      {this.idUser,
      this.fullName,
      this.photo,
      this.email,
      this.phone,
      this.githubPage});
  factory UserDAO.fromJSON(Map<String, dynamic> mapUser) {
    return UserDAO(
      idUser: mapUser['idUser'],
      fullName: mapUser['fullName'],
      photo: mapUser['photo'],
      email: mapUser['email'],
      phone: mapUser['phone'],
      githubPage: mapUser['githubPage'],
    );
  }

  setIdUser(int idUser) {
    this.idUser = idUser;
  }

  setFullName(String fullName) {
    this.fullName = fullName;
  }

  setPhoto(String photo) {
    this.photo = photo;
  }

  setEmail(String email) {
    this.email = email;
  }

  setPhone(String phone) {
    this.phone = phone;
  }

  setGithub(String githubPage) {
    this.githubPage = githubPage;
  }

  int? getIdUser() {
    return idUser;
  }

  String? getFullName() {
    return fullName;
  }

  String? getPhoto() {
    return photo;
  }

  String? getEmail() {
    return email;
  }

  String? getPhone() {
    return phone;
  }

  String? getGithubPage() {
    return githubPage;
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
      where: 'idUser = ?',
      whereArgs: [row['idUser']],
    );
  }

  Future<int> eliminar(int idUser, String nomTabla) async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    return await conexion.delete(
      nomTabla,
      where: 'idUser=?',
      whereArgs: [idUser],
    );
  }

  Future<List<UserDAO>> getAllTareas() async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    var result = await conexion.query('tblUser');
    return result.map((mapTarea) => UserDAO.fromJSON(mapTarea)).toList();
  }

  Future<UserDAO?> getUser(idUser) async {
    _db = DatabaseHelper();
    var conexion = await _db!.database;
    var result =
        await conexion.query('tblUser', where: 'idUser=?', whereArgs: [idUser]);

    return result.isNotEmpty
        ? result.map((mapTarea) => UserDAO.fromJSON(mapTarea)).first
        : null;
  }
}
