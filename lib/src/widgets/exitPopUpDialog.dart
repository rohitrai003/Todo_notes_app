import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Exit App',
            style: TextStyle(fontFamily: "Abeezee"),
          ),
          content: Text(
            'Do you want to exit an App?',
            style: TextStyle(fontFamily: "Abeezee"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              //return true when click on "Yes"
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}
