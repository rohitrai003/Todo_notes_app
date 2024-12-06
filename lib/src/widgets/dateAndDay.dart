import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
String dateFormat = DateFormat('EEEE').format(DateTime.now());

dateAndDay() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currentDate,
          style: const TextStyle(fontSize: 15, fontFamily: "Abeezee"),
        ),
        Text(
          dateFormat,
          style: const TextStyle(fontSize: 15, fontFamily: "Abeezee"),
        ),
      ],
    ),
  );
}
