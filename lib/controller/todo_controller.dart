import 'package:get/get.dart';

import '../data/models/todo_model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs; // Obx for reactive list

  void addOrUpdate(Todo todo) {
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
    } else {
      todos.add(todo);
    }
  }

  void delete(Todo todo) {
    todos.removeWhere((t) => t.id == todo.id);
  }
}
