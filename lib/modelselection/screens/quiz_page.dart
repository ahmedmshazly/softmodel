import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/bloc/quiz_bloc.dart';
import '../domain/bloc/quiz_event.dart';
import '../domain/bloc/quiz_state.dart';
import '../domain/models/questions.dart';
import '../domain/services/quiz.dart';
import '../widgets/buttons_question.dart';
import '../widgets/dropdown_question.dart';
import '../widgets/integer_input_question.dart';
import '../widgets/slider_question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final dropdownSelectedValue = ValueNotifier<String?>(null);
  final intValue = ValueNotifier<int?>(null);
  bool _isLoading = false;

  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to Leave the test !?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('CANCEL',
                      style: TextStyle(color: Color(0xff072f53))),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  child: const Text('Leave',
                      style: TextStyle(color: Color(0xff072f53))),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _showLoadingDialog() {
    setState(() {
      _isLoading = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff072f53)),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
      final currentQuestion = state.questions[state.currentQuestion];

      Widget questionWidget;
      switch (currentQuestion.answerType) {
        case AnswerType.buttons:
          questionWidget = ButtonsQuestion(
            options: currentQuestion.options,
            onSelected: (answer) =>
                context.read<QuizBloc>().add(AnswerQuestion(answer)),
          );
          break;
        case AnswerType.integerInput:
          questionWidget = IntegerInputQuestion(
            onSubmitted: (value) {
              context.read<QuizBloc>().add(AnswerQuestion(value));
            },
            intValue: intValue,
          );
          break;
        case AnswerType.dropdown:
          questionWidget = DropdownQuestion(
            options: currentQuestion.options,
            selectedValue: dropdownSelectedValue,
          );
          break;
        case AnswerType.slider:
          questionWidget = SliderQuestion(
            min: currentQuestion.sliderMin,
            max: currentQuestion.sliderMax,
            onChanged: (answer) =>
                context.read<QuizBloc>().add(AnswerQuestion(answer)),
          );
          break;
        default:
          questionWidget = const SizedBox.shrink();
      }
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'lib/modelselection/assets/images/welcomeback.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    _showLeaveDialog(context);
                  },
                  icon: const Icon(Icons.home),
                )
              ],
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question ${state.currentQuestion + 1}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              backgroundColor: const Color(0xfffbc108),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(),
                            Text(
                              currentQuestion.questionText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff072f53),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.help_outline,
                                color: Color(0xfffbc108),
                              ),
                              onPressed: () {
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
                                            const Text(
                                              'Instructions',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              currentQuestion.description,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff072f53),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (currentQuestion.answerType ==
                                          AnswerType.buttons
                                      ? (currentQuestion.options.length == 3
                                          ? 0.3
                                          : currentQuestion.options.length == 4
                                              ? 0.35
                                              : currentQuestion
                                                          .options.length ==
                                                      5
                                                  ? 0.45
                                                  : currentQuestion
                                                              .options.length ==
                                                          6
                                                      ? 0.5
                                                      : 0.3)
                                      : 0.3),
                              child: questionWidget,
                            ),
                            const Spacer(),
                            // START HERE
                            if (state.currentQuestion ==
                                state.questions.length - 1)
                              ElevatedButton(
                                onPressed: () async {
                                  if (currentQuestion.answerType ==
                                      AnswerType.integerInput) {
                                    context
                                        .read<QuizBloc>()
                                        .add(AnswerQuestion(intValue.value));
                                  } else if (currentQuestion.answerType ==
                                      AnswerType.dropdown) {
                                    context.read<QuizBloc>().add(AnswerQuestion(
                                        dropdownSelectedValue.value));
                                  }

                                  // Collect answers in a map
                                  final Map<String, dynamic> answersMap = {};
                                  for (int i = 0;
                                      i < state.questions.length;
                                      i++) {
                                    final question = state.questions[i];
                                    final answer = state.answers[i];
                                    answersMap[question.questionText] = answer;
                                  }

                                  // Pass answers to quiz class for prediction
                                  final quiz = Quiz(answersDict: answersMap);
                                  quiz.findRecommendedModel();
                                  _showLoadingDialog();
                                  int repeat = 0;
                                  while (!(quiz.recommendedModel is String) &&
                                      repeat < 4) {
                                    // Show progress indicator
                                    await Future.delayed(Duration(seconds: 3));
                                    repeat++;
                                  }
                                  dynamic bestModel = quiz.recommendedModel;
                                  _hideLoadingDialog();
                                  // print(bestModel);
                                  // print(answersMap);

                                  if (bestModel is String) {
                                    // Navigate to result page with best model
                                    Navigator.pushNamed(context, '/result',
                                        arguments: bestModel);
                                  } else {
                                    // Navigate to result page with failure message
                                    Navigator.pushNamed(context, '/result',
                                        arguments: "Failed to load the model");
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xff072f53),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text('Submit'),
                              )
                            else if (state.questions[state.currentQuestion]
                                    .answerType !=
                                AnswerType.buttons)
                              if (state.questions[state.currentQuestion]
                                      .answerType ==
                                  AnswerType.integerInput)
                                ValueListenableBuilder<int?>(
                                  valueListenable: intValue,
                                  builder: (context, selectedValue, _) {
                                    return TextButton(
                                      onPressed: selectedValue != null
                                          ? () {
                                              dropdownSelectedValue.value =
                                                  null;
                                              context
                                                  .read<QuizBloc>()
                                                  .add(ProceedToNextQuestion());
                                            }
                                          : () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "You should enter a valid integer"),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xff072f53),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                      ),
                                      child: const Text(
                                        'Next',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  },
                                )
                              else
                                ValueListenableBuilder<String?>(
                                  valueListenable: dropdownSelectedValue,
                                  builder: (context, selectedValue, _) {
                                    return TextButton(
                                      onPressed: selectedValue != null
                                          ? () {
                                              context
                                                  .read<QuizBloc>()
                                                  .add(ProceedToNextQuestion());
                                            }
                                          : () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "You should choose an answer"),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xff072f53),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                      ),
                                      child: const Text(
                                        'Next',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  },
                                ),

                            const Spacer(),
                          ],
                          // In quiz_page.dart

                          // const Spacer(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
