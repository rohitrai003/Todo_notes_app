import "dart:convert";

import "package:http/http.dart" as http;
import "package:my_todo_app/src/constant/api.dart";
import "package:my_todo_app/src/model/TodoModel.dart";

class TodoController {
  Future addTodo(TodoModel model, String token) async {
    try {
      final response = await http.post(Uri.parse(addTodoUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: jsonEncode(model.toJson()));
      if (response.statusCode == 201) {
        return "Successfully Created";
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return e.toString();
    }
  }

  //To Get Task or Todo
  Future<Map<String, dynamic>> getTodo(String token) async {
    try {
      final response = await http.get(Uri.parse(getTodoUrl),
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 404) {
        return {"message": jsonDecode(response.body)["message"]};
      } else if (response.statusCode == 200) {
        return {"message": jsonDecode(response.body)};
      } else if (response.statusCode == 401) {
        return {"message": "You should log in again"};
      } else {
        return {"message": "Error Occured ${response.body}"};
      }
    } catch (e) {
      return {"message": e.toString()};
    }
  }

//To Update Task or Todo
  Future<bool> updateTodo(
      String title, String userId, String todoId, String token) async {
    final url = Uri.parse('${updateTodoUrl}$userId/$todoId');
    print(url);
    try {
      final response = await http.put(
        url,
        body: json.encode({"title": title}),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print('Todo updated successfully.');
        return true;
      } else {
        print('Failed to update todo: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating todo: $e');
      return false;
    }
  }

  //To Delete Task or Todo
  Future deleteTodo(String userId, String todoId, String token) async {
    final url = Uri.parse(
      '${deleteTodoUrl}$userId/$todoId',
    );
    print(url);
    try {
      final response = await http.delete(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Todo deleted successfully: ${data['todo']}');
      } else {
        print('Failed to delete todo: ${response.body}');
      }
    } catch (e) {
      print('Error toggling todo: $e');
    }
  }

  Future<void> toggleTodo(String userId, String todoId) async {
    final url = Uri.parse('${toggle}$userId/$todoId');
    print(url);
    try {
      final response = await http.put(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Todo updated successfully: ${data['todo']}');
      } else {
        print('Failed to update todo: ${response.body}');
      }
    } catch (e) {
      print('Error toggling todo: $e');
    }
  }
}
