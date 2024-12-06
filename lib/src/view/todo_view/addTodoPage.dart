import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:my_todo_app/src/constant/appColors.dart";
import "package:my_todo_app/src/constant/screenSize.dart";
import "package:my_todo_app/src/controller/token_controller.dart";
import "package:my_todo_app/src/model/TodoModel.dart";
import "package:my_todo_app/src/provider/todo_provider.dart";
import "package:provider/provider.dart";

class AddTodoPage extends StatefulWidget {
  final String userId;
  const AddTodoPage({super.key, required this.userId});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController todo = TextEditingController();

  DateTime selectedDate = new DateTime.now().toLocal();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool isImportant = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: todo,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.task),
                    suffixIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_month)),
                    hintText: "Eg. To Read Book",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    enabled: true,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: Color(0xFFe5e5e5)),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CheckboxListTile(
                  title: Text(
                    "Important ? ",
                    style: TextStyle(fontFamily: "Abeezee", fontSize: 16),
                  ),
                  value: isImportant,
                  onChanged: (value) {
                    setState(() {
                      isImportant = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Dead Line : $formattedDate',
                style: TextStyle(fontFamily: "Abeezee", fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => todoProvider.addTodoProvider(
                  TodoModel(
                      title: todo.text,
                      isImportant: isImportant,
                      createdOn: TimeOfDay.now().format(context),
                      isCompleted: false,
                      deadline: formattedDate),
                  TokenController.token,
                  context),
              child: Text(
                "Add",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  foregroundColor: black,
                  backgroundColor: yellow,
                  fixedSize: Size(screenWidth(context), 50),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
      ),
    );
  }
}
