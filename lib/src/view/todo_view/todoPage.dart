import 'package:flutter/material.dart';
import 'package:my_todo_app/src/constant/api.dart';
import 'package:my_todo_app/src/constant/appColors.dart';

import 'package:my_todo_app/src/constant/screenSize.dart';
import 'package:my_todo_app/src/controller/todo_controller.dart';
import 'package:my_todo_app/src/controller/token_controller.dart';
import 'package:my_todo_app/src/model/TodoModel.dart';
import 'package:my_todo_app/src/provider/todo_provider.dart';
import 'package:my_todo_app/src/view/todo_view/addTodoPage.dart';
import 'package:my_todo_app/src/widgets/customTaskView.dart';
import 'package:page_transition/page_transition.dart';

class TodoScreen extends StatefulWidget {
  final String userId;
  TodoScreen({super.key, required this.userId});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  initState() {
    super.initState();
    print(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purple,
        onPressed: () => Navigator.push(
          context,
          PageTransition(
              child: AddTodoPage(
                userId: widget.userId,
              ),
              type: PageTransitionType.bottomToTop),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1)),
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Todo",
          style: TextStyle(
            fontFamily: "Abeezee",
          ),
        ),
      ),
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
              future: TodoController().getTodo(TokenController.token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No data available"));
                }

                final response =
                    (snapshot.data as Map<String, dynamic>)["message"];
                if (response == null || response is! List) {
                  return Center(child: Text("Something Error Occured"));
                }

                int length = response.length;

                return ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final data = response[index];

                    return CustomTaskView(
                      userId: widget.userId,
                      toggle: (value) {
                        setState(() {
                          data["isCompleted"] = !data["isCompleted"];
                        });
                        TodoController().toggleTaskCompleted(
                            widget.userId, data["_id"], TokenController.token);
                      },
                      todo: TodoModel(
                        createdOn: data["createdOn"] ?? '',
                        isImportant: data["isImportant"] ?? false,
                        sId: data["_id"] ?? '',
                        // isCompleted: data["isCompleted"] ?? false,
                        isCompleted: data["isCompleted"],
                        title: data["title"] ?? '',
                        deadline: data["deadline"],
                      ),
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
