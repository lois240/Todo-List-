import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _tasks = [];

  List<Todo> get tasks => _tasks;

  void addTask(String title) {
    if (title.isEmpty) return;
    _tasks.add(Todo(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  void toggleTask(String id) {
    final taskIndex = _tasks.indexWhere((t) => t.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].toggleDone();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
