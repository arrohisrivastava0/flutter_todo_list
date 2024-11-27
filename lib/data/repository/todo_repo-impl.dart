import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repository/todo_repo.dart';
import '../../services/database_service.dart';

class TodoRepositoryImpl implements TodoRepo {
  final DatabaseService _dbService;

  TodoRepositoryImpl(this._dbService);

  @override
  Future<void> addTodo(Todo todo) async{
    await _dbService.insertTodo(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _dbService.deleteTodo(todo);
  }

  @override
  Future<List<Todo>> getTodos() async{
    return await _dbService.getTodos();
  }

  @override
  Future<void> updateTodo(Todo todo) async{
    await _dbService.updateTodo(todo);
  }

  
}