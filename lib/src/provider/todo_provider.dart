import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_todo_app/src/constant/api.dart';
import 'package:my_todo_app/src/controller/todo_controller.dart';
import 'package:my_todo_app/src/model/TodoModel.dart';
import 'package:http/http.dart' as http;

class TodoProvider extends ChangeNotifier {
  var todo = null;
  saveTodo(String token) async {
    Map<String, dynamic> data = await TodoController().getTodo(token);
    todo = data["message"];
    print(todo);
    // TodoSharedPreference().saveTodoInStorage(todo);
    notifyListeners();
  }

  addTodoProvider(TodoModel model, String token, context) async {
    String value = await TodoController().addTodo(model, token);
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(value)));
  }

  //All state changes for custom task view widget
}
