import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/src/constant/appColors.dart';
import 'package:my_todo_app/src/constant/icons.dart';
import 'package:my_todo_app/src/controller/todo_controller.dart';
import 'package:my_todo_app/src/controller/token_controller.dart';
import 'package:my_todo_app/src/model/TodoModel.dart';
import 'package:my_todo_app/src/provider/themeDataProvider.dart';
import 'package:my_todo_app/src/view/todo_view/editTodoPage.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomTaskView extends StatefulWidget {
  final String userId;
  final TodoModel todo;
  final Function(bool?) toggle;
  CustomTaskView(
      {super.key,
      required this.userId,
      required this.todo,
      required this.toggle});

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

    return Slidable(
      endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 1 / 4,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              padding: EdgeInsets.all(5),
              onPressed: (context) {
                setState(() {
                  widget.todo.isCompleted = !widget.todo.isCompleted!;
                });
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
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: themeProvider.isDark == true ? white : black),
                  borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                leading: Checkbox(
                  value: widget.todo.isCompleted!,
                  activeColor: green,
                  onChanged: (value) {
                    setState(() {
                      widget.todo.isCompleted = !widget.todo.isCompleted!;
                    });
                    TodoController().toggleTaskCompleted(
                        widget.userId, widget.todo.sId!, TokenController.token);
                  },
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.todo.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "Abeezee",
                            color: themeProvider.isDark == true ? white : black,
                            decoration: widget.todo.isCompleted!
                                ? TextDecoration.lineThrough
                                : null)),
                    Text(
                      "Created on: ${formattedDate} at ${formattedTime}",
                      style:
                          const TextStyle(fontSize: 10, fontFamily: "Abeezee"),
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
                                    initialValue: widget.todo.title!,
                                    userId: widget.userId,
                                    id: widget.todo.sId!,
                                    deadline: widget.todo.deadline!,
                                    isCompleted: widget.todo.isCompleted!,
                                    isImportant: widget.todo.isImportant!,
                                    createdOn: widget.todo.createdOn!,
                                  ),
                                  type: PageTransitionType.rightToLeft));
                        },
                        child: ImageIcon(
                          AssetImage(editIcon),
                          size: 30,
                        ),
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
    );
  }
}
