import 'package:flutter/material.dart';
import 'package:wasteagram/main.dart';


class SettingsPageOnWelcome extends StatefulWidget {
  const SettingsPageOnWelcome({ Key? key }) : super(key: key);

  @override
  _SettingsPageOnWelcomeState createState() => _SettingsPageOnWelcomeState();
}

class _SettingsPageOnWelcomeState extends State<SettingsPageOnWelcome> {

  

  @override
  Widget build(BuildContext context) {

    AppState? appState = context.findAncestorStateOfType<AppState>();
    bool _value = appState?.isDarkMode.value == true ? true : false;
    bool BGC = appState?.isDarkMode.value == true ? true : false;


    Widget buildSwitch(BuildContext context) => Transform.scale(
      scale: 1,
      child: Switch.adaptive(

        activeColor: Colors.blueAccent,
        activeTrackColor: Colors.blue.withOpacity(0.4),
        value: _value, 
        onChanged: (newValue) {
          appState?.updateDarkMode();
          setState( () => _value = newValue );
        }

      )
    );



    return Drawer(
        child: Scaffold(
          backgroundColor: BGC ? Colors.grey : Colors.white,
          appBar: AppBar(
            backgroundColor: BGC ? Colors.grey : Colors.white,
            automaticallyImplyLeading: false,
            title: Text('Settings',
              style: TextStyle(color: Colors.black)
            ),
            // backgroundColor: Color(0xffffffff)
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                buildSwitch(context)
              ],
            ),
          )
        )
      );
  }
}