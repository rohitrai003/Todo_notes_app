import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/controller/note_controller.dart';
import 'package:todo_note_app/src/model/NotesModel.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/note_view/addNotesPage.dart';
import 'package:todo_note_app/src/view/note_view/editNotesPage.dart';
import 'package:todo_note_app/src/widgets/customNoteView.dart';

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
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? darkTheme
          : Theme.of(context).scaffoldBackgroundColor,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
            future: NoteController().getNotes(widget.token),
            builder: (context, snapshot) {
              final data = snapshot.data;
              print(data);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data == "Error Occured") {
                return Center(
                    child: Text(
                  "No Notes Found\nYou can add one 😊",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Abeezee', fontSize: 20),
                ));
              } else if (data["statusCode"] == 404) {
                return const Center(
                  child: Text("Unauthorized"),
                );
              } else if (snapshot.data["statusCode"] == 200) {
                if (data["message"] is List) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: data["message"].length,
                      itemBuilder: (context, index) {
                        final response = data["message"][index];
                        return CustomNoteView(
                            model: NotesModel(
                                title: response['title'],
                                subtitle: response['subtitle']),
                            index: index,
                            token: widget.token,
                            userId: widget.userId,
                            id: response['_id']);
                      });
                } else {
                  return Text(data["message"]);
                }
              } else {
                return const Center(
                  child: Text("There was an error occured.😕"),
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
