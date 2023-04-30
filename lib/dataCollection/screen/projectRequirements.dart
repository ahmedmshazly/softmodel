import 'package:flutter/material.dart';
import 'package:softmodel/dataCollection/screen/projectSize.dart';
import 'package:softmodel/dataCollection/widgets/mainAppbar.dart';
import 'package:softmodel/home/widgets/homedrawer.dart';

import '../widgets/progressbar.dart';

class ProjectRequirements extends StatefulWidget {
  const ProjectRequirements({super.key});

  @override
  State<ProjectRequirements> createState() => _ProjectRequirementsState();
}

class _ProjectRequirementsState extends State<ProjectRequirements> {
  int _selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'My App',
          icon: Icons.arrow_back,
          onIconPressed: () => Navigator.of(context).pop(),
          //onDrawerPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
        endDrawer: const HomeDrawer(),
        drawerEnableOpenDragGesture: true,
        body: Container(
            color: Color.fromRGBO(251, 193, 8, 1),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 15),
                Text(
                  "Project requirements",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProgressBar(percentage: 0),
                    SizedBox(
                      width: 10,
                    ),
                    Text("0%",
                        style: TextStyle(color: Colors.white, fontSize: 20))
                  ],
                ),
                SizedBox(height: 15),
                Image(
                  image: AssetImage(
                      r'lib/dataCollection/assets/images/projectrequis.png'),
                ),
                SizedBox(height: 20),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white)),
                      onPressed: () {
                        _showPopupMenu(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          )
                        ],
                      )),
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const projectSize()));
          },
          backgroundColor: Colors.black,
          child: Text("NEXT"),

          // drawer content
        ));
  }

  void _showPopupMenu(BuildContext context) async {
    final selectedOption = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 160, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Text('option 1'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('option 2'),
        ),
        PopupMenuItem(
          value: 3,
          child: Text('Option 3'),
        ),
        PopupMenuItem(
          value: 4,
          child: Text('Option 4'),
        ),
        PopupMenuItem(
          value: 5,
          child: Text('Option 5'),
        ),
      ],
      elevation: 8.0,
    );

    if (selectedOption != null) {
      setState(() {
        _selectedOption = selectedOption;
      });
    }
  }
}
