import "package:flutter_sqlite_app/app/models/notes.dart";
import "package:sqflite/sqflite.dart";
import 'package:sqflite/sqlite_api.dart';
import "package:path_provider/path_provider.dart";
import "dart:io" as io;
import "package:path/path.dart";

class DBHandler {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory docummentDirectory = await getApplicationDocumentsDirectory();
    String path = join(docummentDirectory.path, "notes.db");

    var db = openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT)
    """);
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert("notes", notesModel.toMapWithoutId());

    return notesModel;
  }

  Future<List<NotesModel>> getNotes() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query("notes");

    return queryResult.map((note) => NotesModel.fromMap(note)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;

    return await dbClient!.delete(
      "notes",
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<int> update(NotesModel notesModel) async {
    var dbClient = await db;

    return await dbClient!.update(
      "notes",
      notesModel.toMap(),
      where: "id = ?",
      whereArgs: [notesModel.id]
    );
  }
}
