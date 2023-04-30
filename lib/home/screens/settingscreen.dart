import 'package:flutter/material.dart';
import 'package:softmodel/home/widgets/homedrawer.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shadowColor: const Color(0xff072f53),
        title: const Text('Settings'),
      ),
      body: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.language, color: Color(0xff072f53)),
          title: const Text(
            'Language',
            style: TextStyle(color: Color(0xff072f53)),
          ),
          trailing: DropdownButton<String>(
            value: 'English',
            onChanged: (_) {},
            items: <String>['English', 'French', 'Spanish', 'German']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.notifications, color: Color(0xff072f53)),
          title:
              const Text('Notifications', style: TextStyle(color: Color(0xff072f53))),
          trailing: Switch(
            value: true,
            onChanged: (_) {},
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.brightness_medium, color: Color(0xff072f53)),
          title: const Text('Theme', style: TextStyle(color: Color(0xff072f53))),
          trailing: DropdownButton<String>(
            value: 'Light',
            onChanged: (_) {},
            items: <String>['Light', 'Dark']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.security,
            color: Color(0xff072f53),
          ),
          title: const Text('Privacy', style: TextStyle(color: Color(0xff072f53))),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xff072f53),
          ),
          onTap: () {
            // Navigate to privacy page
          },
        ),
        const Divider(),
      ],
    ),
    );
  }
}
