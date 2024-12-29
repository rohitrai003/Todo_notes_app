import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';

String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
String dateFormat = DateFormat('EEEE').format(DateTime.now());

class DateAndDayWidget extends StatefulWidget {
  const DateAndDayWidget({super.key});

  @override
  State<DateAndDayWidget> createState() => _DateAndDayWidgetState();
}

class _DateAndDayWidgetState extends State<DateAndDayWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      decoration: BoxDecoration(
        color: themeProvider.isDark == true
            ? darkTheme
            : Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
            width: 0,
            color:
                themeProvider.isDark == true ? darkTheme : Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentDate,
            style: TextStyle(
                fontSize: 15,
                fontFamily: "Abeezee",
                color: themeProvider.isDark == true ? white : black),
          ),
          Text(
            dateFormat,
            style: TextStyle(
                fontSize: 15,
                fontFamily: "Abeezee",
                color: themeProvider.isDark == true ? white : black),
          ),
        ],
      ),
    );
  }
}
