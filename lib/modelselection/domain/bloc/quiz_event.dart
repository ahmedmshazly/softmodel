import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
}

class AnswerQuestion extends QuizEvent {
  final dynamic answer;

  const AnswerQuestion(this.answer);

  @override
  List<Object> get props => [answer];
}

class ProceedToNextQuestion extends QuizEvent {
  @override
  List<Object> get props => [];
}
