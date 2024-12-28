import 'package:flutter/material.dart';
import 'package:todo_note_app/src/controller/todo_controller.dart';
import 'package:todo_note_app/src/model/TodoModel.dart';

class TodoProvider extends ChangeNotifier {
  var todo = null;
  saveTodo(String token) async {
    Map<String, dynamic> data = await TodoController().getTodo(token);
    todo = data["message"];
    print(todo);
    notifyListeners();
  }

  addTodoProvider(TodoModel model, String token, context) async {
    String value = await TodoController().addTodo(model, token);
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(value)));
  }
}
