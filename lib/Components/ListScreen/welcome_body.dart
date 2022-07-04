import 'package:flutter/material.dart';
import 'package:wasteagram/Components/ListScreen/add_button.dart';
import 'package:wasteagram/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeBody extends StatefulWidget {

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {


  @override
  Widget build(BuildContext context) {

    AppState? appState = context.findAncestorStateOfType<AppState>();

    return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              leading: Text(post['testVar']),
                              title: Text('This is the testVar value'));
                        },
                      ),
                    ),
                    // ElevatedButton(
                    //   child: Text('Select photo and upload data'),
                    //   onPressed: () {
                    //     uploadData();
                    //   },
                    // ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    // ElevatedButton(
                    //   child: Text('Select photo and upload data'),
                    //   onPressed: () {
                    //     uploadData();
                    //   },
                    // ),
                  ],
                );
              }
            });
    

  }

}
    
    
    
    
    
//     Center(
//         child: FractionallySizedBox(
//           // heightFactor: 0.9,
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child:Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(child: Container()),
//                 Expanded(child: Container(
//                   child: Column(
//                     children: [
//                       Icon(Icons.fastfood,
//                         size: 72,
//                       ),
//                       // Text('Wasteagram',
//                       //   style: Theme.of(context).textTheme.headline5
//                       // ),

//                     ],
//                   )
//                 )),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: addButton(context)
//                 ),
//               ]
//             )
//           )
//         )
//       );

