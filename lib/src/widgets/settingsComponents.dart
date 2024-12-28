// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/screenSize.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:provider/provider.dart';

class SettingsComponents extends StatelessWidget {
  SettingsComponents(
      {super.key,
      required this.icon,
      required this.title,
      required this.onClick,
      required this.hasSwitch});
  Icon icon;
  String title;
  Function onClick;
  bool hasSwitch;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: InkWell(
            onTap: () => onClick(),
            borderRadius: BorderRadius.circular(15),
            child: Container(
                padding: const EdgeInsets.all(5),
                width: screenWidth(context),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: icon,
                    ),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(fontFamily: "Abeezee", fontSize: 18),
                  ),
                  trailing: hasSwitch
                      ? Switch(
                          value: themeProvider.isDark,
                          onChanged: (value) {
                            themeProvider.toggleTheme(context);
                          },
                        )
                      : Icon(Icons.arrow_forward_ios),
                ))));
  }
}
