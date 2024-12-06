import 'package:flutter/material.dart';
import 'package:my_todo_app/src/constant/appColors.dart';
import 'package:my_todo_app/src/view/note_view/addNotesPage.dart';

class NotesScreen extends StatefulWidget {
  final String userId;
  const NotesScreen({super.key, required this.userId});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [],
          )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotesPage(),
              ));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1)),
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Notes",
          style: TextStyle(
            fontFamily: "Abeezee",
          ),
        ),
      ),
    );
  }
}
