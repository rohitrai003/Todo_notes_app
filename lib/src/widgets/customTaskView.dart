import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/constant/icons.dart';
import 'package:todo_note_app/src/controller/todo_controller.dart';
import 'package:todo_note_app/src/model/TodoModel.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/todo_view/editTodoPage.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomTaskView extends StatefulWidget {
  final String userId;
  final TodoModel todo;
  final String token;
  final Function updateState;
  CustomTaskView({
    super.key,
    required this.updateState,
    required this.token,
    required this.userId,
    required this.todo,
  });

  @override
  State<CustomTaskView> createState() => _CustomTaskViewState();
}

class _CustomTaskViewState extends State<CustomTaskView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    DateTime date = DateTime.parse(widget.todo.createdOn!);
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    String formattedTime = DateFormat('hh:mm a').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 1 / 4,
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(5),
                padding: EdgeInsets.all(5),
                onPressed: (context) {
                  widget.updateState();
                  TodoController().deleteTodo(
                      widget.userId, widget.todo.sId!, widget.token);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: themeProvider.isDark ? white : black),
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Checkbox(
                    value: widget.todo.isCompleted!,
                    activeColor: green,
                    onChanged: (value) {
                      print("Value: $value");
                      setState(() {
                        widget.todo.isCompleted = !widget.todo.isCompleted!;
                      });

                      TodoController()
                          .toggleTodo(widget.userId, widget.todo.sId!);
                    },
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.todo.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "Abeezee",
                              color:
                                  themeProvider.isDark == true ? white : black,
                              decoration: widget.todo.isCompleted!
                                  ? TextDecoration.lineThrough
                                  : null)),
                      Text(
                        "Created on: ${formattedDate} at ${formattedTime}",
                        style: TextStyle(
                            color: themeProvider.isDark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 10,
                            fontFamily: "Abeezee"),
                      )
                    ],
                  ),
                  trailing: SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: EditTodoPage(
                                      token: widget.token,
                                      todo: widget.todo,
                                      userId: widget.userId,
                                      initialValue: widget.todo.title!,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: Icon(Icons.edit,
                              color:
                                  themeProvider.isDark == true ? white : black,
                              size: 25),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: widget.todo.isImportant == true
                              ? Colors.purple
                              : black,
                          size: 25,
                          grade: 1,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
