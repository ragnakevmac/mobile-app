import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/Components/home_page.dart';
import 'package:wasteagram/Components/ListScreen/entries_page.dart';
import 'package:wasteagram/Models/wasteagramDTO.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';



class EntryForm extends StatefulWidget {
  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  
  final formKey = GlobalKey<FormState>();
  final wasteagramEntryFields = WasteagramEntryFields();



  File? image;
  final picker = ImagePicker();


  Future getImage() async {

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }


  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getTempImage());
  }






  void getTempImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
  }





  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null ? Container(width: 200.0, height: 200.0, child: Image.file(image!)) : CircularProgressIndicator(),
        Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: formFields(context)))),
      ],
    );
  }

  List<Widget> formFields(BuildContext context) {
    return [
      // TextFormField(
      //   initialValue: 'Twice Concert',
      //   autofocus: true,
      //   decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
      //   onSaved: (value) {
      //     wasteagramEntryFields.title = value!;
      //   },
      //   validator: (value) => validateTitle(value ?? ""),
      // ),
      // SizedBox(height: 20),

      // TextFormField(
      //     initialValue: 'Momo is so cute!',
      //     autofocus: true,
      //     decoration: InputDecoration(labelText: 'Body', border: OutlineInputBorder()),
      //     onSaved: (value) {
      //       wasteagramEntryFields.body = value!;
      //     },
      //     validator: (value) => validateBody(value ?? "")),
      // SizedBox(height: 10),

      TextFormField(
          // initialValue: '4',
          autofocus: true,
          decoration: InputDecoration(labelText: 'Number of Wasted Items', border: OutlineInputBorder()),
          onSaved: (value) {
            wasteagramEntryFields.numWastedItems = int.parse(value!);
          },
          validator: (value) => validateRating(value ?? "")),
      SizedBox(height: 10),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.routeName);
              },
              child: Text('Cancel')),
          ElevatedButton(onPressed: () => validateAndSubmit(context), child: Text('Upload')),
        ],
      )
    ];
  }



  void validateAndSubmit(BuildContext context) async {
    final formState = formKey.currentState;

    if (formState != null && formState.validate()) {

      formKey.currentState?.save();
      wasteagramEntryFields.dateTime = DateTime.now();


      // final Database database = await openDatabase(
      //   'wasteagram.db', version: 1, onCreate: (Database db, int version) async {
      //     await db.execute(
      //        await rootBundle.loadString('assets/schema.txt'));
      //   }
      // );
      // await database.transaction((txn) async {
      //   await txn.rawInsert('INSERT INTO wasteagram_entries(title, body, rating, date) VALUES(?, ?, ?, ?)',
      //     [wasteagramEntryFields.title, wasteagramEntryFields.body, wasteagramEntryFields.rating, wasteagramEntryFields.dateTime.toString()]
      //   );
      // });
      // await database.close();


      final url = await getImage();
      FirebaseFirestore.instance.collection('posts').add({
        'url': url, 
        'numWastedItems': wasteagramEntryFields.numWastedItems,
        'dateTime': wasteagramEntryFields.dateTime,

      });




      Navigator.pushNamed(context, HomePage.routeName);
    }
  }




  // String? validateTitle(String title) {
  //   if (title == '') {
  //     return 'Title cannot be blank';
  //   } else
  //     return null;
  // }

  // String? validateBody(String body) {
  //   if (body == '') {
  //     return 'Body cannot be blank';
  //   } else
  //     return null;
  // }

  String? validateRating(String rating) {
    if (rating == '') {
      return 'Input cannot be blank';
    }

    bool isNumeric(String str) {
      if (str == null) {
        return false;
      }
      return double.tryParse(str) != null;
    }

    if (!isNumeric(rating)) {
      return 'Numbers only';
    } else {
        return null;
    }
  }
}
