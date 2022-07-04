import 'package:flutter/material.dart';
import 'package:wasteagram/main.dart';




class SettingsPageOnForm extends StatefulWidget {
  const SettingsPageOnForm({ Key? key }) : super(key: key);

  @override
  _SettingsPageOnFormState createState() => _SettingsPageOnFormState();
}

class _SettingsPageOnFormState extends State<SettingsPageOnForm> {

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