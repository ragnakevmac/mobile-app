import 'package:flutter/material.dart';
import 'package:wasteagram/main.dart';
import 'package:wasteagram/Components/ListScreen/entries_body.dart';
import 'package:wasteagram/Components/NewPost/form_field_page.dart';
import 'package:wasteagram/Components/Settings/settings_page_on_welcome.dart';

class EntriesPage extends StatefulWidget {
  static final routeName = 'Entries';

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {

  @override
  Widget build(BuildContext context) {

    AppState? appState = context.findAncestorStateOfType<AppState>();
    bool BGC = appState?.isDarkMode.value == true ? true : false;


    return Scaffold(
        backgroundColor: BGC ? Colors.grey : Colors.white,
        endDrawer: SettingsPageOnWelcome(),
        appBar: AppBar(
          backgroundColor: BGC ? Colors.black54 : Colors.blueAccent,
          automaticallyImplyLeading: false,
          title: Center(child: Text('Wasteagram')),
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
        body: EntriesBody());
  }
}
