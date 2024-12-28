import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/constant/icons.dart';

// ignore: must_be_immutable
class CustomTextInput extends StatefulWidget {
  CustomTextInput(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.hintText,
      required this.icon,
      required this.isHidden});

  TextEditingController controller;
  TextInputType keyboardType;
  String hintText;
  bool isHidden;
  Icon icon;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        obscureText: widget.hintText == "Password" ? widget.isHidden : false,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        style: TextStyle(color: darkGrey),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          fillColor: lightGrey,
          filled: true,
          hintText: widget.hintText,
          hintStyle:
              TextStyle(fontSize: 18, color: darkGrey, fontFamily: "Abeezee"),
          prefixIcon: widget.icon,
          suffixIcon: widget.hintText == "Password"
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isHidden = !widget.isHidden;
                        });
                      },
                      icon: Image.asset(
                        widget.isHidden
                            ? passwordHideIcon
                            : "assets/icons/view.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      )),
                )
              : null,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
