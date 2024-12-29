import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/controller/note_controller.dart';
import 'package:todo_note_app/src/model/NotesModel.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/note_view/editNotesPage.dart';

class CustomNoteView extends StatefulWidget {
  CustomNoteView(
      {super.key,
      required this.model,
      required this.index,
      required this.token,
      required this.userId,
      required this.id});
  NotesModel model;
  int index;
  String token;
  String userId;
  String id;
  @override
  State<CustomNoteView> createState() => _CustomNoteViewState();
}

class _CustomNoteViewState extends State<CustomNoteView> {
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    return Card(
      color: notesColor[widget.index % notesColor.length].withOpacity(0.8),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model.title!,
              style: TextStyle(
                  fontFamily: 'Abeezee', fontSize: 20, color: textColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.model.subtitle!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Abeezee', fontSize: 15, color: textColor),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Note"),
                        content: Text(
                            "Are you sure you want to delete this note?",
                            style: TextStyle(
                                color: textColor, fontFamily: 'Abeezee')),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: textColor, fontFamily: 'Abeezee'),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final res = await NoteController().deleteNotes(
                                  widget.token, widget.userId, widget.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res.toString())));
                              Navigator.pop(context);
                            },
                            child: Text("Yes",
                                style: TextStyle(
                                    color: textColor, fontFamily: 'Abeezee')),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNotesPage(
                            title: widget.model.title!,
                            notes: widget.model.subtitle!,
                            updateNotes: (p0) async {
                              final res = await NoteController().updateNotes(
                                  widget.token, p0, widget.id, widget.userId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res.toString())));
                            },
                          ),
                        ));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: textColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      // Expanded(child: Container()),
      // Text(data["message"][index]["date"]),
    );
  }
}
