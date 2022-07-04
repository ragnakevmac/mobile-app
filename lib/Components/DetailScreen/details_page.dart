import 'package:flutter/material.dart';
import 'package:wasteagram/Models/wasteagram_entry.dart';
import 'package:wasteagram/main.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/Components/ListScreen/entries_page.dart';
import 'package:wasteagram/Components/home_page.dart';
import 'package:wasteagram/Components/NewPost/entry_form.dart';
import 'package:wasteagram/Components/DetailScreen/entry_details.dart';
import 'package:wasteagram/Components/Settings/settings_page_on_form.dart';

class DetailsPage extends StatefulWidget {
  static final routeName = 'Details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    AppState? appState = context.findAncestorStateOfType<AppState>();
    bool BGC = appState?.isDarkMode.value == true ? true : false;

    return Scaffold(
        backgroundColor: BGC ? Colors.grey : Colors.white,
        endDrawer: SettingsPageOnForm(),
        appBar: AppBar(
          backgroundColor: BGC ? Colors.black54 : Colors.blueAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 36,
                ),
                onTap: () {
                  Navigator.pushNamed(context, HomePage.routeName);
                },
              ),
              Center(child: Text('Wasteagram')),
              Container()
            ],
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.settings),
              );
            })
          ],
        ),
        body: EntryDetails(args: args));
  }
}
