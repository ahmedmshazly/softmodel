import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softmodel/dataCollection/screen/projectRequirements.dart';
import 'package:softmodel/home/screens/accountscreen.dart';
import 'package:softmodel/home/widgets/homedrawer.dart';
import 'package:softmodel/modelselection/domain/bloc/quiz_bloc.dart';
import 'package:softmodel/modelselection/domain/bloc/quiz_state.dart';
import 'package:softmodel/modelselection/screens/quiz_page.dart';
import 'package:softmodel/modelselection/screens/welcomescreen.dart';
// import 'package:softmodel/modelselection/screens/welcomescreen.dart';

import '../../main.dart';
import '../../modelselection/domain/models/questions.dart';
import '../../modelselection/domain/services/quiz.dart';
import '../widgets/homebutton.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final quiz = Quiz();

  Future<void> test() async {
    // await quiz.findRecommendedModel();
    // print('Recommended Model: ${quiz.getRecommendedModel}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[900],
      drawer: HomeDrawer(),
      body: SafeArea(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      HomeButton(
                        label: 'Model\nSelection',
                        icon: Icons.account_balance,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ModelSelectionWelcomePage()),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      HomeButton(
                        label: 'Model\nComparison',
                        icon: Icons.compare,
                        onPressed: () async {
                          test();
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      HomeButton(
                        label: 'Saved\nModels',
                        icon: Icons.save,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 16,
          // ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Recently Viewed Models',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              leading: const Icon(
                                Icons.insert_drive_file,
                                size: 60,
                                color: Colors.amber,
                              ),
                              title: Text(
                                'Model Name $index',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff072f53)),
                              ),
                              subtitle: Text(
                                'Model description goes here...',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
