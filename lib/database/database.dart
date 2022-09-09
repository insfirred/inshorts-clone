import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsModel{
  final int id;
  final String title;
  final String description;
  final String date;
  final String url;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.url
  });
}

class ColumnFields{
  // Column Field Names
  static const String id = '_id';
  static const String title = 'title';
  static const String description = '_description';
  static const String date = 'date';
  static const String url = 'url';
}

class DatabaseClass{

  DatabaseClass._privateConstructor();
  static final DatabaseClass instance = DatabaseClass._privateConstructor();

  static Database? _database;

  static const _dbName = 'myDatabase.db';
  static const _dbVersion = 1;
  static const tableName = 'NewsTable';


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
  Future<int> delete(String url) async{
    Database db = await instance.database;
    return await db.delete(tableName,where: '${ColumnFields.url} = ?',whereArgs: [url]);
  }
}