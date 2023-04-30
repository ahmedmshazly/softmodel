import 'package:equatable/equatable.dart';
import '../models/questions.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final Map<int, dynamic> answers; // added field
  final int currentQuestion;

  QuizState({
    required this.questions,
    required this.answers,
    required this.currentQuestion,
  });

  QuizState copyWith({int? currentQuestion, Map<int, dynamic>? answers}) {
    return QuizState(
      questions: this.questions,
      answers: answers ?? this.answers,
      currentQuestion: currentQuestion ?? this.currentQuestion,
    );
  }

  @override
  List<Object?> get props => [questions, answers, currentQuestion];
}
