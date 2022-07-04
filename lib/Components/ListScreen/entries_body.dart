import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/Components/ListScreen/add_button.dart';
import 'package:wasteagram/Components/DetailScreen/details_page.dart';
import 'package:wasteagram/Components/ListScreen/portrait.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wasteagram/Models/wasteagramDTO.dart';
import 'package:wasteagram/Models/wasteagram_entry.dart';
import 'package:wasteagram/Models/wasteagram.dart';

class EntriesBody extends StatefulWidget {
  const EntriesBody({Key? key}) : super(key: key);

  @override
  State<EntriesBody> createState() => _EntriesBodyState();
}

class _EntriesBodyState extends State<EntriesBody> {

  late String title = '';
  late String body = '';
  late String rating = '';
  late String dateTime = '';

  late Wasteagram wasteagram;
  

  @override
  void initState() {

    super.initState();

    wasteagram = Wasteagram(entries: []);

    loadWasteagram();

  }

  void loadWasteagram() async {

    final Database database = await openDatabase(
      'wasteagram.db', version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          await rootBundle.loadString('assets/schema.txt'));
      }
    );
    List<Map> wasteagramRecords = await database.rawQuery('SELECT * FROM wasteagram_entries');
    final wasteagramEntries = wasteagramRecords.map( (record) {
      return WasteagramEntry(
        title: record['title'],
        body: record['body'],
        rating: record['rating'],
        dateTime: DateTime.parse(record['date']));
    }).toList();

    setState(() {
      wasteagram = Wasteagram(entries: wasteagramEntries);

      title = wasteagram.entries[wasteagram.entries.length - 1].title;
      body = 'Notes: ' + wasteagram.entries[wasteagram.entries.length - 1].body;
      rating = 'rating: ' + wasteagram.entries[wasteagram.entries.length - 1].rating.toString() + '/4';
      dateTime = DateFormat('EEEE, MMMM dd, yyyy').format(wasteagram.entries[wasteagram.entries.length - 1].dateTime);
    });

  }


  setData(titleP, bodyP, ratingP, dateTimeP) {
    setState(() {
      title = titleP;
      body = 'Notes: ' + bodyP;
      rating = 'rating: ' + ratingP.toString() + '/4';
      dateTime = DateFormat('EEEE, MMMM dd, yyyy').format(dateTimeP);
    });
  }



  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: layoutDecider);

    // MediaQuery.of(context).orientation == Orientation.portrait ? Portrait(args: wasteagram.entries) : Landscape(args: wasteagram.entries);


}

  Widget layoutDecider(BuildContext context, BoxConstraints constraints) {

    return constraints.maxWidth < 700 ? Portrait(args: wasteagram.entries) : Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  int reversed_index = wasteagram.entries.length - 1 - index;

                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(wasteagram.entries[reversed_index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [Text(DateFormat('EEEE, MMMM dd, yyyy').format(wasteagram.entries[reversed_index].dateTime))],
                          ),
                        ],
                      ),
                    ),
                    onTap: () { setData(
                      wasteagram.entries[reversed_index].title,
                      wasteagram.entries[reversed_index].body,
                      wasteagram.entries[reversed_index].rating,
                      wasteagram.entries[reversed_index].dateTime,
                      ); },
                  );
                },
                separatorBuilder: (context, reversed_index) => Divider(),
                itemCount: wasteagram.entries.length,
              ),
            ),
            Column(
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                Text(body, style: TextStyle(fontSize: 16)),
                Text(rating, style: TextStyle(fontSize: 16)),
                Text(dateTime, style: TextStyle(fontSize: 16)),
              ],
            ),

            

          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: addButton(context))
      ],
    );
      
  }
}