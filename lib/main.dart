import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/Components/home_page.dart';
import 'package:wasteagram/Components/ListScreen/entries_page.dart';
import 'package:wasteagram/Components/ListScreen/welcome_body.dart';
import 'package:wasteagram/Components/NewPost/form_field_page.dart';
import 'package:wasteagram/Components/DetailScreen/details_page.dart';
import 'package:wasteagram/Components/Settings/settings_page_on_welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
    
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  runApp(App(title: 'Location Services'));
}

class App extends StatefulWidget {

  final String title;

  const App({Key? key, required this.title}) : super(key: key);

  static final routes = {
    HomePage.routeName: (context) => HomePage(),
    FormFieldPage.routeName: (context) => FormFieldPage(),
    EntriesPage.routeName: (context) => EntriesPage(),
    DetailsPage.routeName: (context) => DetailsPage()
  };

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {

  late IsDarkMode isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = IsDarkMode(initialValue: false);
    initMyDarkMode(isDarkMode);
  }


  void initMyDarkMode(isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode.value = prefs.getBool('myDarkMode') == true ? true : false;
    });
  }



  void updateDarkMode() {
    setState( () {
      isDarkMode.toggleBool();
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: App.routes,
    );
  }
}


class IsDarkMode {

  bool value;

  IsDarkMode({required bool initialValue}) : value = initialValue;

  void toggleBool() async {
    value = !value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('myDarkMode', value);
  }

}

