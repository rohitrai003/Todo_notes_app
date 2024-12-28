import 'package:flutter/material.dart';
import 'package:todo_note_app/src/constant/appColors.dart';
import 'package:todo_note_app/src/provider/userDataProvider.dart';
import 'package:todo_note_app/src/widgets/dateAndDay.dart';
import 'package:todo_note_app/src/widgets/exitPopUpDialog.dart';
import 'package:todo_note_app/src/constant/icons.dart';
import 'package:todo_note_app/src/provider/bottomBarToggle.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/view/note_view/notesPage.dart';
import 'package:todo_note_app/src/view/main_view/settingsPage.dart';
import 'package:todo_note_app/src/view/todo_view/todoPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getUserData(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final toggleProvider = Provider.of<BottomBarToggle>(context);
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    final List<Map<String, dynamic>> pages = [
      {
        "title": "Todo",
        "screen": TodoScreen(
            userId: userDataProvider.userDetails["_id"] ?? "",
            token: widget.token)
      },
      {
        "title": "Notes",
        "screen": NotesScreen(
            userId: userDataProvider.userDetails["_id"] ?? "",
            token: widget.token)
      },
      {
        "title": "Settings",
        "screen": SettingsPage(
            name: userDataProvider.userDetails["name"] ?? "",
            email: userDataProvider.userDetails["email"] ?? "")
      },
    ];

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            pages[toggleProvider.index]["title"],
            style: const TextStyle(fontSize: 35, fontFamily: "Abeezee"),
          ),
        ),
        body: userDataProvider.dataLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    dateAndDay(),
                    Expanded(
                      child: pages[toggleProvider.index]["screen"],
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: toggleProvider.index,
          onTap: toggleProvider.toggleItems,
          selectedItemColor: themeProvider.isDark ? yellow : Colors.purple,
          unselectedItemColor: themeProvider.isDark ? white : black,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(clipboardIcon)),
              label: "Todo",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(notesIcon)),
              label: "Notes",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
