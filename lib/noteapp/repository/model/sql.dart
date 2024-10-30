import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final sqfProvider = Provider((ref) => SqfliteMake());

class SqfliteMake {


 static final SqfliteMake _instance = SqfliteMake._internal();
 Database? _database;
  SqfliteMake._internal();

  factory SqfliteMake() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'note_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body TEXT,
            date DATE
          )
          ''');
      },
    );
  }
}
