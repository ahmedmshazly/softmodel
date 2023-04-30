import 'package:flutter/material.dart';
import 'package:softmodel/dataCollection/screen/costDelay.dart';
import 'package:softmodel/dataCollection/widgets/mainAppbar.dart';
import 'package:softmodel/home/widgets/homedrawer.dart';

import '../widgets/progressbar.dart';

class projectComplexity extends StatefulWidget {
  const projectComplexity({super.key});

  @override
  State<projectComplexity> createState() => _projectComplexityState();
}

class _projectComplexityState extends State<projectComplexity> {
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
          color: const Color.fromRGBO(251, 193, 8, 1),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "Project Complexity",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProgressBar(percentage: 24),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("24%",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ],
              ),
              const SizedBox(height: 15),
              const Image(
                image: AssetImage(
                    r'lib/dataCollection/assets/images/city-lights-through-rain-window 1.png'),
              ),
              const SizedBox(height: 20),
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
                      children: const [
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
              MaterialPageRoute(builder: (context) => const projectDelay()));
        },
        backgroundColor: Colors.black,
        child: const Text("NEXT"),
      ),
      // drawer content
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final selectedOption = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 160, 0, 0),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Text('option 1'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('option 2'),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text('Option 3'),
        ),
        const PopupMenuItem(
          value: 4,
          child: Text('Option 4'),
        ),
        const PopupMenuItem(
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
