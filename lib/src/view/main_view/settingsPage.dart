import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/provider/token_provider.dart';
import 'package:todo_note_app/src/widgets/settingsComponents.dart';
import 'package:todo_note_app/src/constant/screenSize.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/auth_view/signUpPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final String name;
  final String email;
  SettingsPage({super.key, required this.email, required this.name});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    print(widget.name);
  }

  Future<void> signOut() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
    print('Sign-out successful! Token removed.');
  }

  Future<void> checkNotificationPermission() async {
    PermissionStatus notification = await Permission.notification.status;
    if (!notification.isGranted) {
      PermissionStatus permissionStatus =
          await Permission.notification.request();
      if (permissionStatus.isGranted) {
        print("Is granted");
      } else {
        print("Is not granted");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(children: [
              InkWell(
                onTap: () {},
                child: Ink(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              backgroundColor: black,
                              radius: screenHeight(context) * 0.035,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: screenHeight(context) * 0.034,
                                  child: Text(
                                    widget.name[0],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                      fontFamily: "Abeezee",
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.email,
                                  style: TextStyle(
                                      fontFamily: "Abeezee", fontSize: 15.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text("Edit"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SettingsComponents(
                icon: Icon(Icons.alarm),
                title: "Notification",
                onClick: () => checkNotificationPermission(),
                hasSwitch: false,
              ),
              SettingsComponents(
                icon: Icon(Icons.logout),
                title: "Dark Mode",
                onClick: () => themeProvider.toggleTheme(context),
                hasSwitch: true,
              ),
              SettingsComponents(
                icon: Icon(Icons.logout),
                title: "Logout",
                onClick: () async {
                  await Provider.of<TokenProvider>(context, listen: false)
                      .clearToken();
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                hasSwitch: false,
              )
            ])),
      ),
    );
  }
}
