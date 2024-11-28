//UI layer
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/todo_cubit.dart';

import '../domain/models/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showTodoAddBox(BuildContext context) {
    final textController = TextEditingController();
    final todoCubit = context.read<TodoCubit>();

    showDialog(context: context, builder: (context) =>
        AlertDialog(
          content: TextField(controller: textController,),
          actions: [
            //cancel
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')
            ),
            //add
            TextButton(
                onPressed: () {
                  todoCubit.addTodo(textController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Add')
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showTodoAddBox(context);
        },
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos){
          return ListView.builder(
            itemCount: todos.length,
              itemBuilder: (context, index){
                final todo=todos[index];
                return ListTile(
                  title: Text(
                      todo.title,
                    style: TextStyle(
                      color: todo.isCompleted
                          ? (isDarkMode ? Colors.grey[600] : Colors.grey)
                          : (isDarkMode ? Colors.white : Colors.black),
                      decoration:
                      todo.isCompleted? TextDecoration.lineThrough: TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) { todoCubit.toggleCompleted(todo); },
                  ),
                  trailing: IconButton(
                      onPressed: ()=>todoCubit.deleteTodo(todo),
                      icon: const Icon(Icons.delete)
                  )
                );
              }
          );
        },
      ),
    );
  }
}
