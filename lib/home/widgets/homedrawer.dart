import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:softmodel/home/screens/accountscreen.dart';
import 'package:softmodel/home/screens/homescreen.dart';
import 'package:softmodel/home/screens/settingscreen.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('CANCEL', style: TextStyle(color: Color(0xff072f53))),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushNamedAndRemoveUntil(
                    context, '/log', (route) => false);
              },
              child:
                  const Text('LOG OUT', style: TextStyle(color: Color(0xff072f53))),
            ),
            ],)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    String username = 'Anonymous';
    String email = 'anonymous@anonymous.com';
    Widget photo = const Icon(
      Icons.account_circle,
      size: 60,
      color: Colors.white,
    );

    if (user != null) {
      final emailParts = user.email!.split('@');
      username = emailParts.first;
      email = user.email!;
      photo = const Icon(
      Icons.account_circle,
      size: 60,
      color: Colors.white,
    );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                photo,
                const SizedBox(height: 10),
                Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color(0xff072f53),
            ),
            title: const Text(
              'Home Page',
              style: TextStyle(color: Color(0xff072f53)),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color(0xff072f53),
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Color(0xff072f53)),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Color(0xff072f53),
            ),
            title: const Text(
              'Account',
              style: TextStyle(color: Color(0xff072f53)),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AccountScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color(0xff072f53),
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(color: Color(0xff072f53)),
            ),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
