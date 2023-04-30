import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final VoidCallback onIconPressed;
  //final VoidCallback onDrawerPressed;

  const MyAppBar({
    Key? key,
    required this.title,
    required this.icon,
    required this.onIconPressed,
    //required this.onDrawerPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      leading: Image(
        image:
            AssetImage(r'lib/dataCollection/assets/images/softmodel-logo.png'),
      ),

      title: Text(title),
      //actions: [
      //IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      //],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
