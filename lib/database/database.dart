import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsModel{
  final int? id;
  final String title;
  final String description;
  final String date;
  final String url;

  NewsModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.url
  });
}

class ColumnFields{
  // Column Field Names
  static final String id = '_id';
  static final String title = 'title';
  static final String description = '_description';
  static final String date = 'date';
  static final String url = 'url';
}

class DatabaseClass{

  DatabaseClass._privateConstructor();
  static final DatabaseClass instance = DatabaseClass._privateConstructor();

  static Database? _database;

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final tableName = 'NewsTable';


  Future<Database> get database async{
    if(_database!=null) {
      return _database!;
    }

    _database = await createDB(_dbName);
    return _database!; 
  }

  Future<Database> createDB(String dbName) async{
    final dbPath = await getDatabasesPath();
    String path = join(dbPath,dbName);
    return await openDatabase(path,version: 1, onCreate: onCreated);
  }

  Future onCreated(Database db, int version) async{
    db.execute(
      '''
      CREATE TABLE $tableName(
          ${ColumnFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${ColumnFields.title} TEXT NOT NULL,
          ${ColumnFields.description} TEXT NOT NULL,
          ${ColumnFields.date} TEXT NOT NULL,
          ${ColumnFields.url} TEXT NOT NULL
        )
      '''
    );
  }

  // Create Operation
  Future<int> create(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // Read Operation
  Future<List<Map<String,dynamic>>> read()async{
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // Delete Operation
  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(tableName,where: '${ColumnFields.id} = ?',whereArgs: [id]);
  }
}