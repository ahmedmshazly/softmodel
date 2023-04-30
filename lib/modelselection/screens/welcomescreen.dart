import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:softmodel/modelselection/screens/quiz_page.dart';

import '../domain/bloc/quiz_bloc.dart';
import '../domain/bloc/quiz_state.dart';
import '../domain/models/questions.dart';

class ModelSelectionWelcomePage extends StatefulWidget {
  const ModelSelectionWelcomePage({super.key});

  @override
  State<ModelSelectionWelcomePage> createState() => _ModelSelectionWelcomePageState();
}

class _ModelSelectionWelcomePageState extends State<ModelSelectionWelcomePage>
    with SingleTickerProviderStateMixin {
  void _showInstructionsDialog(String title, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff072f53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage(r"lib\modelselection\assets\images\welcomeback.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          // drawer: const HomeDrawer(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.question_mark_rounded),
                onPressed: () {
                  _showInstructionsDialog("Instructions",
                      "Welcome to our test this is where you will be answering some questions and we will use it");
                },
              ),
            ],
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Model Selection',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: const Color(0xfffbc108),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _animation,
                          child: Text(
                            'W',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.25,
                              color: const Color(0xff072f53),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ScaleTransition(
                              scale: _animation,
                              child: Text(
                                'elcome to Model Selection Test!',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  color: const Color(0xff072f53),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ScaleTransition(
                      scale: _animation,
                      child: SvgPicture.asset(
                        r'lib\modelselection\assets\images\function.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  if (_showButton)
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) => QuizBloc(QuizState(
                                        questions: sampleQuestions(),
                                        answers: {},
                                        currentQuestion: 0,
                                      )),
                                      child: QuizPage(),),
                            ),
                          );
                          
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xff072f53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Start Test',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
