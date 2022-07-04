import 'package:flutter/material.dart';
import 'package:wasteagram/Components/ListScreen/add_button.dart';
import 'package:wasteagram/Components/DetailScreen/details_page.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/Models/wasteagramDTO.dart';
import 'package:wasteagram/Models/wasteagram_entry.dart';
import 'package:wasteagram/Models/wasteagram.dart';


class Portrait extends StatefulWidget {
  var args;
  Portrait({Key? key, this.args}) : super(key: key);

  @override
  _PortraitState createState() => _PortraitState();
}

class _PortraitState extends State<Portrait> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              int reversed_index = widget.args.length - 1 -index;
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('EEEE, MMMM dd, yyyy').format(widget.args[reversed_index].dateTime), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.args[reversed_index].rating.toString(), style: TextStyle(fontSize: 30,)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    DetailsPage.routeName,
                    arguments: widget.args[reversed_index],
                  );
                },
              );
            },
            separatorBuilder: (context, reversed_index) => Divider(),
            itemCount: widget.args.length,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: addButton(context))
      ],
    );
  }
}