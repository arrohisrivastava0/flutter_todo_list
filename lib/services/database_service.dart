import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/domain/models/todo.dart';

class DatabaseService{
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;
  DatabaseService._constructor();

  Future<Database> get database async{
    if(_db!=null) return _db!;
    _db=await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async{
    final databaseDirPath=await getDatabasesPath();
    final databasePath=join(databaseDirPath, "master_db.db");
    final database=await openDatabase(
        databasePath,
      onCreate: (db, version){
          db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            isCompleted INTEGER NOT NULL
          )
          ''');
      }
    );
    return database;
  }

  // Add a Todo
  Future<int> insertTodo(Todo todo) async {
    final db = await getDatabase();
    return await db.insert('todos', todo.toMap());
  }
  // Update a Todo
  Future<int> updateTodo(Todo todo) async {
    final db = await getDatabase();
    return await db.update('todos', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }
  // Delete a Todo
  Future<int> deleteTodo(Todo todo) async {
    final db = await getDatabase();
    return await db.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
  }
  // Fetch Todos
  Future<List<Todo>> getTodos() async {
    final db = await getDatabase();
    final maps = await db.query('todos');
    return maps.map((map) => Todo.fromMap(map)).toList();
  }
}