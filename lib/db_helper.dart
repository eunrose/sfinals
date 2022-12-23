

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite1/home_page.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Todos.db');
    return await openDatabase(
        path, version: 1, onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
      id INTEGER PRIMARY KEY,
      name TEXT
      )
    ''');
  }

  Future<List<Todos>> getTodos () async {
    Database db = await instance.database;
    var todos = await db.query('todos', orderBy: 'name');
    List<Todos>? todosList = todos.isNotEmpty ?
        todos.map((c) => Todos.fromMap(c)).toList()
        : [];
    return todosList;
  }
  Future<int> add (Todos todos) async {
    Database db = await instance.database;
    return await db.insert('todos' , todos.toMap());
  }
  Future<int> remove (int id) async {
    Database db = await instance.database;
    return await db.delete('todos' , where: 'id', whereArgs: ['id'] );
  }
  Future<int> update (Todos todos) async {
    Database db = await instance.database;
    return await db.update('todos' , todos.toMap(), where: 'id = ?', whereArgs: [todos.id]);
  }
}