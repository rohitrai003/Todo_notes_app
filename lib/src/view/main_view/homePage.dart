import 'package:flutter/material.dart';
import 'package:my_todo_app/src/constant/appColors.dart';
import 'package:my_todo_app/src/controller/auth_controller.dart';
import 'package:my_todo_app/src/controller/token_controller.dart';
import 'package:my_todo_app/src/widgets/dateAndDay.dart';
import 'package:my_todo_app/src/widgets/exitPopUpDialog.dart';
import 'package:my_todo_app/src/constant/icons.dart';
import 'package:my_todo_app/src/provider/bottomBarToggle.dart';
import 'package:my_todo_app/src/provider/themeDataProvider.dart';
import 'package:my_todo_app/src/provider/userDataProvider.dart';
import 'package:my_todo_app/src/view/note_view/notesPage.dart';
import 'package:my_todo_app/src/view/main_view/settingsPage.dart';
import 'package:my_todo_app/src/view/todo_view/todoPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String token;
  HomePage({required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool dataLoaded = true;
  late Map<String, dynamic> userDetails;

  Future<void> getUserData() async {
    try {
      final data = await AuthController().fetchUserData(TokenController.token);
      setState(() {
        userDetails = data;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataPovider>(context);
    final toggleProvider = Provider.of<BottomBarToggle>(context);
    final themeProvider = Provider.of<ThemeDataProvider>(context);

    List pages = [
      {"title": "Todo", "screen": TodoScreen(userId: userData.userId)},
      {"title": "Notes", "screen": NotesScreen(userId: userData.userId)},
      {
        "title": "Settings",
        "screen":
            SettingsPage(name: userDetails["name"], email: userDetails["email"])
      }
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(pages[toggleProvider.index]["title"],
              style: const TextStyle(fontSize: 35, fontFamily: "Abeezee")),
        ),
        body: SafeArea(
            child: userDetails.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: [
                    dateAndDay(),
                    Expanded(child: pages[toggleProvider.index]["screen"])
                  ])),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: toggleProvider.index,
            onTap: toggleProvider.toggleItems,
            selectedItemColor: themeProvider.isDark ? yellow : Colors.purple,
            unselectedItemColor: themeProvider.isDark ? white : black,
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(clipboardIcon),
                  ),
                  label: "Todo"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.calendar_month_outlined),
              //     label: "Upcoming Items"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(notesIcon)), label: "Notes"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ]),
      ),
    );
  }
}
