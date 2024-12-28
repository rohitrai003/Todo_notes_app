import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/widgets/customTextInput.dart';
import 'package:todo_note_app/src/constant/screenSize.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/auth_view/signInPage.dart';

import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  late Map<String, dynamic> user;

  register() async {
    if (_email.text.isEmpty &&
        _password.text.isEmpty &&
        _fullName.text.isEmpty) {
      ScaffoldMessenger(child: Text("Please fill the above fields"));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight(context) * 0.3, //Change it to 0.3
              width: screenWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME",
                    style: TextStyle(fontSize: 70, fontFamily: "Abeezee"),
                  ),
                  Text(
                    "Let’s get started with the journey.",
                    style: TextStyle(fontSize: 25, fontFamily: "Abeezee"),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Container(
              height: screenHeight(context) * 0.6, //Change it to 0.6
              width: screenWidth(context),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              decoration: BoxDecoration(
                  color: themeProvider.isDark == true ? darkTheme : white,
                  border: themeProvider.isDark == true
                      ? Border.all(width: 1, color: white)
                      : Border.all(width: 0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(50, 50, 93, 0.25),
                      blurRadius: 5,
                      spreadRadius: -1,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        blurRadius: 3,
                        spreadRadius: -1,
                        offset: Offset(0, 1)),
                  ]),
              child: Column(
                children: [
                  Text("Create your new Account",
                      style: TextStyle(
                          color: themeProvider.isDark == true ? white : black,
                          fontSize: 25,
                          fontFamily: "Abeezee")),
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextInput(
                    controller: _fullName,
                    keyboardType: TextInputType.name,
                    hintText: "Enter Your Full Name",
                    isHidden: false,
                    icon: Icon(Icons.person_2_rounded),
                  ),
                  CustomTextInput(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                      isHidden: false,
                      icon: Icon(Icons.email_outlined)),
                  CustomTextInput(
                    controller: _password,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Password",
                    isHidden: true,
                    icon: Icon(Icons.lock),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () => register(),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(screenWidth(context), 50),
                            backgroundColor: green,
                            foregroundColor: black,
                            textStyle:
                                TextStyle(fontSize: 20, fontFamily: "Abeezee"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text("Sign Up")),
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  themeProvider.isDark == true ? white : black,
                              fontFamily: "Abeezee")),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontFamily: "Abeezee"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
