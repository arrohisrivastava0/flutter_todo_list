import 'package:flutter/material.dart';
import 'package:todo/presentation/todo_page.dart';
import 'package:todo/services/database_service.dart';
import 'data/repository/todo_repo-impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService.instance;
  final todoRepository = TodoRepositoryImpl(databaseService);
  runApp(MyApp(todoRepository: todoRepository));
}


class MyApp extends StatelessWidget {
  final TodoRepositoryImpl todoRepository;
  const MyApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepository),
    );
  }
}
