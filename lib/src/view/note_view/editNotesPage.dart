import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/constant/screenSize.dart';
import 'package:todo_note_app/src/model/NotesModel.dart';

// ignore: must_be_immutable
class EditNotesPage extends StatefulWidget {
  EditNotesPage({
    super.key,
    required this.title,
    required this.notes,
    required this.updateNotes,
  });
  String title;
  String notes;
  Function(NotesModel model) updateNotes;

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title.text = widget.title;
    _notes.text = widget.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Notes",
          style: TextStyle(fontSize: 20, fontFamily: "Abeezee"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Title",
                  style: TextStyle(fontSize: 30, fontFamily: "Abeezee"),
                ),
              ),
              TextField(
                controller: _title,
                decoration: InputDecoration(fillColor: lightGrey, filled: true),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text("Notes",
                    style: TextStyle(fontSize: 30, fontFamily: "Abeezee")),
              ),
              TextField(
                minLines: 15,
                maxLines: 20,
                maxLength: 300,
                controller: _notes,
                decoration: InputDecoration(
                  fillColor: lightGrey,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    widget.updateNotes(
                        NotesModel(title: _title.text, subtitle: _notes.text));

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: yellow,
                      minimumSize: Size(screenWidth(context) / 1.1, 50),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontFamily: "Abeezee"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
