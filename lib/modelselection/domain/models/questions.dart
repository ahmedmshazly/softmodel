import 'package:equatable/equatable.dart';

enum AnswerType { buttons, dropdown, slider, integerInput }

class Question extends Equatable {
  final String questionText;
  final String description;
  final AnswerType answerType;
  final List<String> options;
  final double sliderMin;
  final double sliderMax;

  Question({
    required this.questionText,
    required this.description,
    required this.answerType,
    this.options = const [],
    this.sliderMin = 0,
    this.sliderMax = 10,
  });

  @override
  List<Object?> get props =>
      [questionText, description, answerType, options, sliderMin, sliderMax];
}

List<Question> sampleQuestions() {
  return [
    Question(
      questionText: 'What is the size of your project?',
      description: 'Please choose the size that best describes your project.',
      answerType: AnswerType.buttons,
      options: [
        "Small",
        "Small-Medium",
        "Medium",
        "Medium-Large",
        "Large",
        "Extra Large"
      ],
    ),
    Question(
      questionText: 'What type of project are you working on?',
      description:
          'Select the category that best fits the nature of your project.',
      answerType: AnswerType.dropdown,
      options: [
        "Web",
        "Mobile",
        "Desktop",
        "Enterprise",
        "Embedded",
        "Safety-critical",
        "Complex",
        "Data-intensive",
        "Research",
        "Experimental",
        "Consumer-facing",
        "Business-to-business",
        "Internal",
        "Other"
      ],
    ),
    Question(
      questionText:
          'How flexible is your project with respect to changing requirements?',
      description:
          'Indicate how easily your project can adapt to changes in requirements or scope.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
      questionText: "Which methodology best describes your project's approach?",
      description:
          'Select the methodology that best aligns with your project management approach.',
      answerType: AnswerType.dropdown,
      options: [
        "Linear",
        "Iterative",
        "Incremental",
        "Agile",
        "Component-based",
        "Process-based",
        "Model-based",
        "Architectural",
        "Design",
        "Programming Paradigm",
        "Estimation",
        "Process Improvement",
        "Development Practice",
        "Other"
      ],
    ),
    Question(
      questionText:
          'How important is communication and collaboration in your project?',
      description:
          'Indicate the level of importance of effective communication and collaboration within your team.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
      questionText:
          'How much emphasis does your project place on planning and documentation?',
      description:
          'Indicate the level of importance of planning and documentation for your project.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
        Question(
      questionText: 'How much focus does your project have on risk management?',
      description:
          'Indicate the level of importance of risk management for your project.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
      questionText: 'How important is quality assurance in your project?',
      description:
          'Indicate the level of importance of quality assurance for your project.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
        questionText: "What is your project's release strategy?",
        description:
            'Select the release strategy that best describes how your project is deployed or updated.',
        answerType: AnswerType.dropdown,
        options: [
          "Scheduled",
          "Frequent",
          "Continuous",
          "As needed",
          "Fixed intervals",
          "Rolling wave",
          "Other"
        ]),
    Question(
      questionText:
          'How involved are your customers in the development process?',
      description:
          'Indicate the level of involvement of your customers or users in the development process.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
      questionText:
          'How much emphasis does your project place on resource management?',
      description:
          'Indicate the level of importance of resource management for your project.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
      questionText:
          'How important are metrics and measurement in your project?',
      description:
          'Indicate the level of importance of metrics and measurement for your project.',
      answerType: AnswerType.buttons,
      options: ["Low", "Low-Medium", "Medium", "Medium-High", "High"],
    ),
    Question(
      questionText:
          'What is the  team size for your project at any given point of time? approximate',
      description:
          'Enter an approximate number of team members working on your project at any given time.',
      answerType: AnswerType.integerInput,
    ),
    Question(
      questionText:
          'What type of use cases does your project primarily focus on?',
      description:
          'Select the use case category that your project primarily focuses on.',
      answerType: AnswerType.dropdown,
      options: [
        "New development",
        "Maintenance",
        "Integration",
        "Migration",
        "Redesign",
        "Refactoring",
        "Optimization",
        "Research & development",
        "Other"
      ],
    ),
  ];
}
