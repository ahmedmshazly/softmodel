import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softmodel/modelselection/domain/bloc/quiz_event.dart';
import 'package:softmodel/modelselection/domain/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc(QuizState initialState) : super(initialState);

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is AnswerQuestion) {
      yield _answerQuestion(event);
    } else if (event is ProceedToNextQuestion) {
      if (state.currentQuestion + 1 < state.questions.length) {
        yield state.copyWith(currentQuestion: state.currentQuestion + 1);
      }
    }
  }

  QuizState _answerQuestion(AnswerQuestion event) {
    final answers = Map<int, dynamic>.from(state.answers);
    answers[state.currentQuestion] = event.answer;

    final nextQuestion = state.currentQuestion + 1;

    return QuizState(
      questions: state.questions,
      answers: answers,
      currentQuestion: nextQuestion < state.questions.length
          ? nextQuestion
          : state.currentQuestion,
    );
  }
}
