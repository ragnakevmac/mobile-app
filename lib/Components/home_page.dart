import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/Components/ListScreen/add_button.dart';
import 'package:wasteagram/Components/ListScreen/entries_body.dart';
import 'package:wasteagram/Components/ListScreen/welcome_body.dart';
import 'package:wasteagram/Components/NewPost/form_field_page.dart';
import 'package:wasteagram/Components/Settings/settings_page_on_welcome.dart';
import 'package:wasteagram/Components/ListScreen/entries_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wasteagram/Models/wasteagram_entry.dart';
import 'package:wasteagram/Models/wasteagram.dart';
import 'package:wasteagram/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/Components/DetailScreen/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Wasteagram journal;

  @override
  void initState() {
    super.initState();

    journal = Wasteagram(entries: []);

    initIsWelcomePage();
  }

  void initIsWelcomePage() async {
    //TOGGLE and Hot Restart to DELETE DATABASE!
    // await deleteDatabase('journal.db');

    final Database database = await openDatabase('journal.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(await rootBundle.loadString('assets/schema.txt'));
    });
    List<Map> journalRecords =
        await database.rawQuery('SELECT * FROM journal_entries');
    final journalEntries = journalRecords.map((record) {
      return WasteagramEntry(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          dateTime: DateTime.parse(record['date']));
    }).toList();

    setState(() {
      journal = Wasteagram(entries: journalEntries);
    });
  }

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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // print(snapshot.hasData);
              if (snapshot.hasData &&
                  snapshot.data!.docs != null &&
                  snapshot.data!.docs.length > 0) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var post = snapshot.data!.docs[index];
                          return ListTile(
                            title: Text(DateFormat('EEEE, MMMM dd, yyyy')
                                .format(post['dateTime'].toDate())),
                            trailing: Text(post['numWastedItems'].toString()),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DetailsPage.routeName,
                                  arguments: post);
                            },
                          );
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: addButton(context)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text('You have no posts.',
                                  style: TextStyle(fontSize: 20))),
                          Center(
                              child: Text(
                                  'Add a post by clicking the button below!',
                                  style: TextStyle(fontSize: 20))),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: addButton(context)),
                  ],
                );
              }
            }));
  }
}
