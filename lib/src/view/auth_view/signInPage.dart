import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/provider/authProvider.dart';
import 'package:todo_note_app/src/widgets/customTextInput.dart';
import 'package:todo_note_app/src/constant/screenSize.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/auth_view/signUpPage.dart';
import 'package:todo_note_app/src/view/auth_view/forgotPassword.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight(context) * 0.3,
              width: screenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME BACK",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 60, fontFamily: "Abeezee"),
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight(context) * 0.6,
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
                      offset: Offset(
                        0,
                        2,
                      ),
                    ),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        blurRadius: 3,
                        spreadRadius: -1,
                        offset: Offset(
                          0,
                          1,
                        )),
                  ]),
              child: Column(
                children: [
                  Text("Login To Your Account",
                      style: TextStyle(
                          color: themeProvider.isDark == true ? white : black,
                          fontSize: 25,
                          fontFamily: "Abeezee")),
                  const SizedBox(
                    height: 40,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ForgotPassword(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: blue, fontSize: 15, fontFamily: "Abeezee"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                        // onPressed: () => signIn(context),
                        onPressed: () => authProvider.signIn(
                            context: context,
                            email: _email.text,
                            password: _password.text),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(screenWidth(context), 50),
                            backgroundColor: green,
                            foregroundColor: black,
                            textStyle: const TextStyle(
                                fontSize: 20, fontFamily: "Abeezee"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: authProvider.isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text("Sign In")),
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Doesn't have an Account?",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: themeProvider.isDark == true ? white : black,
                            fontFamily: "Abeezee"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ));
                        },
                        child: Text(
                          "Create One",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                              fontFamily: "Abeezee"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
