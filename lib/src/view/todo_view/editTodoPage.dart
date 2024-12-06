import 'package:flutter/material.dart';
import 'package:my_todo_app/src/constant/appColors.dart';

// ignore: must_be_immutable
class EditTodoPage extends StatefulWidget {
  String initialValue;
  String userId;
  String id;
  bool isCompleted;
  bool isImportant;
  String createdOn;
  String deadline;
  EditTodoPage(
      {super.key,
      required this.deadline,
      required this.isCompleted,
      required this.createdOn,
      required this.isImportant,
      required this.initialValue,
      required this.id,
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
                onPressed: () {},
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
