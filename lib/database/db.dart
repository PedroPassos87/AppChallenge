import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  //SQLite instance
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'analise.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async{
    await db.execute(_conta);
    await db.execute(_myApps);

    await db.insert('conta',{'capacidade':0});
  }

  String get _conta => '''
    CREATE TABLE conta(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      capacidade REAL
    );
  ''';

  String get _myApps => '''
    CREATE TABLE myApps(
      name TEXT PRIMARY KEY,
      limite REAL,
      gasto TEXT,
      
    );
  ''';





}
