import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/controller/todo_controller.dart';
import 'package:todo_note_app/src/model/TodoModel.dart';

// ignore: must_be_immutable
class EditTodoPage extends StatefulWidget {
  String initialValue;
  String userId;
  final TodoModel todo;
  final String token;

  EditTodoPage(
      {super.key,
      required this.token,
      required this.todo,
      required this.initialValue,
      required this.userId});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text("Edit Todo Task", style: TextStyle(fontFamily: "Abeezee"))),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            Expanded(child: Container()),
            ElevatedButton(
                onPressed: () async {
                  final success = await TodoController().updateTodo(
                    _controller.text,
                    widget.userId,
                    widget.todo.sId!,
                    widget.token,
                  );
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Todo updated successfully!')),
                    );
                    Navigator.pushReplacementNamed(context, '/home',
                        arguments: widget.token);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update Todo')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width - 20, 50)),
                child: const Text(
                  "Update",
                  style: TextStyle(fontFamily: "Abeezee"),
                ))
          ],
        )),
      ),
    );
  }
}
