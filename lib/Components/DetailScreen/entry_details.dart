import 'package:flutter/material.dart';
import 'package:wasteagram/Components/DetailScreen/details_page.dart';
import 'package:wasteagram/Components/DetailScreen/share_location_screen.dart';
import 'package:intl/intl.dart';

class EntryDetails extends StatefulWidget {
  var args;
  EntryDetails({Key? key, this.args}) : super(key: key);

  @override
  _EntryDetailsState createState() => _EntryDetailsState();
}

class _EntryDetailsState extends State<EntryDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                    '${DateFormat('EEE, MMMM dd, yyyy').format(widget.args['dateTime'].toDate())}',
                    style: TextStyle(
                      fontSize: 30,
                    )),
              )),
              Expanded(
                child: Image.network(widget.args['url']),
                // Text(widget.args['url'],
                //     style:
                //         TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Text('${widget.args['numWastedItems'].toString()} items',
                    style: TextStyle(
                      fontSize: 30,
                    )),
              )),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20.0),
              //   child: Text('Location: (-12312312, 12131233123)'),
              // ),
              ShareLocationScreen()
            ],
          ),
        ),
      ),
    );
  }
}
