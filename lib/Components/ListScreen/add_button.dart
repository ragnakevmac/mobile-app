// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:wasteagram/Components/NewPost/form_field_page.dart';
// import 'package:image_picker/image_picker.dart';

// class AddButton extends StatefulWidget {
//   const AddButton({ Key? key }) : super(key: key);

//   @override
//   State<AddButton> createState() => AddButtonState();
// }






// class AddButtonState extends State<AddButton> {


//   File? image;
//   final picker = ImagePicker();


//   // @override
//   // void initState() {
//   //   super.initState();

//   // }




//   void displayFormField(BuildContext context) {
//       Navigator.pushNamed(context, FormFieldPage.routeName);
//   }

//   void getImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     image = File(pickedFile!.path);
//     setState(() {});
    
//     if (image != null) {
//       displayFormField(context);
//     }
//   }





//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       // child: Text('+', style: TextStyle(fontSize: 24)),
//       child: Column(
//         children: [
//           Icon(Icons.camera_alt),
          
//         ],
//       ),
//       style: ElevatedButton.styleFrom(
//         shape: CircleBorder(),
//         padding: EdgeInsets.all(20),
//       ),
//       onPressed: () {
//         getImage();
        
//       });
//   }
// }




import 'package:flutter/material.dart';
import 'package:wasteagram/Components/NewPost/form_field_page.dart';




Widget addButton(BuildContext context) {

  void displayFormField(BuildContext context) {
    Navigator.pushNamed(context, FormFieldPage.routeName);
  }


  return ElevatedButton(
      // child: Text('+', style: TextStyle(fontSize: 24)),
      child: Icon(Icons.camera_alt),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
      onPressed: () {
        displayFormField(context);
      });
}

