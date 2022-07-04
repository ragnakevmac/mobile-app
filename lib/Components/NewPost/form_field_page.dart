// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:wasteagram/Components/ListScreen/add_button.dart';
// import 'package:wasteagram/main.dart';
// import 'package:wasteagram/Components/home_page.dart';
// import 'package:wasteagram/Components/NewPost/entry_form.dart';
// import 'package:wasteagram/Components/Settings/settings_page_on_form.dart';


// class FormFieldPage extends StatefulWidget {
  
//   static final routeName = 'FormField';

//   @override
//   State<FormFieldPage> createState() => _FormFieldPageState();
// }

// class _FormFieldPageState extends State<FormFieldPage> {

//   @override
//   Widget build(BuildContext context) {

//     AppState? appState = context.findAncestorStateOfType<AppState>();
//     AddButtonState? addButtonState = context.findAncestorStateOfType<AddButtonState>();

//     bool BGC = appState?.isDarkMode.value == true ? true : false;



//     return Scaffold(
//       backgroundColor: BGC ? Colors.grey : Colors.white,
//       endDrawer: SettingsPageOnForm(),
//       appBar: AppBar(
//         backgroundColor: BGC ? Colors.black54 : Colors.blueAccent,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               child: Icon(
//                 Icons.keyboard_arrow_left,
//                 size: 36,
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, HomePage.routeName);
//               },
//             ),
//             Center(child: Text('New Post')),
//             Container()
//           ],
//         ),
//         actions: [
//           Builder(
//             builder: (context) {
//               return IconButton(
//                 onPressed: () { Scaffold.of(context).openEndDrawer(); },
//                 icon: const Icon(Icons.settings),
//               );
//             }
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             EntryForm()
//           ])
//         )
//       );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wasteagram/main.dart';
import 'package:wasteagram/Components/home_page.dart';
import 'package:wasteagram/Components/NewPost/entry_form.dart';
import 'package:wasteagram/Components/Settings/settings_page_on_form.dart';


class FormFieldPage extends StatefulWidget {
  
  static final routeName = 'FormField';

  @override
  State<FormFieldPage> createState() => _FormFieldPageState();
}

class _FormFieldPageState extends State<FormFieldPage> {

  @override
  Widget build(BuildContext context) {

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
            Center(child: Text('New Post')),
            Container()
          ],
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () { Scaffold.of(context).openEndDrawer(); },
                icon: const Icon(Icons.settings),
              );
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [EntryForm()])
        )
      );
  }
}