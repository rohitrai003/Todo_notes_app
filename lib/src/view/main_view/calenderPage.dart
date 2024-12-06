import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  bool isLoading = true;
  String selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String url = "http://localhost:3000/getTodoByDate/";
  String newUrl = '';
  delay(int time) {
    Future.delayed(
        Duration(seconds: time),
        () => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2050),
            currentDate: DateTime.now(),
            onDateChanged: (data) => {
                  setState(() {
                    newUrl = url;
                    String _currentDate = DateFormat("yyyy-MM-dd").format(data);
                    selectedDate = _currentDate;
                    newUrl = url + selectedDate;
                    print(newUrl);
                    delay(3);
                  })
                }),
        Expanded(
            child: Column(
          children: [
            Text(
              'Selected Date : $selectedDate \n URL: $newUrl',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: Container(
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.purple,
                      )
                    : Text("No todo today"),
              ),
            ))
          ],
        ))
      ],
    ));
  }
}
