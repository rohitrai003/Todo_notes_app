import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/constant/screenSize.dart';

emptyList(BuildContext context, Future reload()) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/emptyTodolist.json",
            width: screenWidth(context) * 0.6, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Empty List",
            style: TextStyle(
                fontSize: screenHeight(context) * 0.03,
                fontFamily: 'Abeezee',
                letterSpacing: 4),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              reload();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: black),
                    borderRadius: BorderRadius.circular(5))),
            child: Text(
              "Reload",
              style: TextStyle(fontFamily: "Abeezee"),
            ))
      ],
    ),
  );
}
