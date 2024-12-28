import 'dart:convert';

import 'package:todo_note_app/src/constant/api.dart';
import 'package:todo_note_app/src/model/NotesModel.dart';
import 'package:http/http.dart' as http;

class NoteController {
  Future addNotes(NotesModel model, String token) async {
    try {
      final response = await http.post(Uri.parse(addNotesUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: jsonEncode(model.toJson()));
      print(response.body);
      if (response.statusCode == 200) {
        return "Successfully Created";
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future getNotes(String token) async {
    try {
      final response =
          await http.get(Uri.parse(getNotesUrl), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });
      final data = response.body;
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(data);
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteNotes(String token, String userId, String noteId) async {
    try {
      String _url = deleteNotesUrl + userId + "/" + noteId;
      print(_url);
      final response = await http.delete(Uri.parse(_url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authorization': "Bearer $token"
          });
      print(response.body);
      if (response.statusCode == 200) {
        return "Successfully Deleted";
      } else {
        return "Error Occured";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
