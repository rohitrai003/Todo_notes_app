import "dart:convert";

import "package:http/http.dart" as http;
import "package:my_todo_app/src/constant/api.dart";
import "package:my_todo_app/src/model/TodoModel.dart";

class TodoController {
  //To Add Task or Todo
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
  Future updateTodo() async {}
  //To Delete Task or Todo
  Future deleteTodo() async {}
  //To Toggle between task completed or not
  Future<void> toggleTaskCompleted(
      String userId, String todoId, String token) async {
    final _url = Uri.parse(toggle + userId + todoId);
    print(userId);
    print(todoId);
    try {
      final response = await http.put(
        _url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Update the local task list
        print(responseData);
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
