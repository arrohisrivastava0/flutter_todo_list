//Interface

import 'package:todo/domain/models/todo.dart';
abstract class TodoRepo{
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<void> updateTodo(Todo todo);

}