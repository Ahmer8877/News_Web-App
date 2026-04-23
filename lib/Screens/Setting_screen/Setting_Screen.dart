import 'package:flutter/material.dart';

bool isSwitch=false;

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.orangeAccent),),
            Text('s',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.brown),),
          ],
        )
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        children: [
          
          //switch themes
          
          Card(
            child: ListTile(
              title: Text('Switch Themes'),
              trailing: Switch(
                  value: isSwitch,
                  onChanged: (value){}
              ),
            ),
          ),
          
          //About section
          Card(
            child: ListTile(
              title: Text('About'),
              subtitle: Text('version 1.0'),
            ),
          )
        ],
      ),
    );
  }
}
