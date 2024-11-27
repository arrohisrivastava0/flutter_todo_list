//State management BLoC - Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repository/todo_repo.dart';

import '../domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{
  final TodoRepo todoRepo;
  TodoCubit(this.todoRepo): super([]){
    loadTodos();
  }

  Future<void> loadTodos() async{
    final todoList=await todoRepo.getTodos();
    emit(todoList);
  }

  Future<void> addTodo(String todoTitle) async{
    final newTodo=Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: todoTitle);
    await todoRepo.addTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async{
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  // Future<void> updateTodo(String todoTitle) async{
  //   final newTodo=Todo(
  //       id: DateTime.now().millisecondsSinceEpoch,
  //       title: todoTitle);
  //   await todoRepo.addTodo(newTodo);
  //   loadTodos();
  // }

  Future<void> toggleCompleted(Todo todo) async{
    final updatedTodo=await todo.toggleCompletion();
    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }
}