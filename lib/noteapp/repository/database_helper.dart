import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/noteapp/repository/model/sql.dart';
import 'package:riverpod_mvvm_template/noteapp/repository/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

final taskRepoProvider =
    Provider((ref) => DatabaseHelper(ref.watch(sqfProvider)));

class DatabaseHelper {
   final SqfliteMake sqfliteMake;
   DatabaseHelper(this.sqfliteMake);

  Future<List<Tasks>> getTask() async {
    Database db = await sqfliteMake.database;
    List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((map) => Tasks.fromMap(map)).toList();
  }

  Future<int> insertTask(Tasks tasks) async {
    Database db = await sqfliteMake.database;
    return await db.insert('tasks', tasks.toMap());
  }

  Future<int> updateTask(Tasks tasks) async {
    Database db = await sqfliteMake.database;
    return await db.update(
      'tasks',
      tasks.toMap(),
      where: 'id = ?',
      whereArgs: [tasks.id],
    );
  }

  Future<int> deleteTask(int id) async {
    Database db = await sqfliteMake.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
