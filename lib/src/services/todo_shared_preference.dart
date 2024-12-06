import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";

class TodoSharedPreference {
  String _key = "todo";

  Future<void> saveTodoInStorage(List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = list.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(_key, stringList);
  }

  Future<List<Map<String, dynamic>>> loadTodoFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(_key);
    if (stringList != null) {
      return stringList
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    }
    return [];
  }
}
