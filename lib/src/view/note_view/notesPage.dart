import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/controller/note_controller.dart';
import 'package:todo_note_app/src/provider/token_provider.dart';
import 'package:todo_note_app/src/view/note_view/addNotesPage.dart';

class NotesScreen extends StatefulWidget {
  final String userId;
  final String token;
  const NotesScreen({super.key, required this.userId, required this.token});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NoteController().getNotes(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
            future: NoteController().getNotes(widget.token),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data["statusCode"] == 200) {
                print(data);
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final response = data["message"][index];
                      return Card(
                        color: notesColor[index % notesColor.length],
                        elevation: 0,
                        child: ListTile(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Note"),
                                content: const Text(
                                    "Are you sure you want to delete this note?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final res = await NoteController()
                                          .deleteNotes(widget.token,
                                              widget.userId, response["_id"]);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(res.toString())));
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          },
                          title: Text(
                            response["title"],
                            style:
                                TextStyle(fontFamily: 'Abeezee', fontSize: 20),
                          ),
                          subtitle: Text(
                            response["subtitle"],
                            style: TextStyle(
                              fontFamily: "Abeezee",
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("No Notes"),
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotesPage(
                  token: widget.token,
                ),
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
