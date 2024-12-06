// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_todo_app/src/constant/appColors.dart';
import 'package:my_todo_app/src/constant/screenSize.dart';

class AddNotesPage extends StatefulWidget {
  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Notes",
          style: TextStyle(fontFamily: "Abeezee"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontSize: 25, fontFamily: "Abeezee"),
              ),
              TextField(
                controller: _titleController,
                style: TextStyle(fontFamily: "Abeezee", color: darkTheme),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.abc),
                    hintText: "Title",
                    hintStyle: TextStyle(fontFamily: "Abeezee", color: black),
                    fillColor: lightGrey,
                    filled: true),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Notes",
                  style: TextStyle(fontSize: 25, fontFamily: "Abeezee")),
              TextField(
                minLines: 10,
                maxLines: 15,
                style: TextStyle(fontFamily: "Abeezee", color: black),
                controller: _subtitleController,
                decoration: InputDecoration(
                  hintText: "Enter your notes here...",
                  hintStyle: TextStyle(fontFamily: "Abeezee", color: black),
                  fillColor: lightGrey,
                  filled: true,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isEmpty &&
                      _subtitleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("You can't save an empty notes.")));
                  } else {}
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    fixedSize: Size(screenWidth(context), 50),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 20, fontFamily: "Abeezee", color: black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
