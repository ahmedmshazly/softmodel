import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class Quiz {
  Map<String, dynamic> answersDict;
  // static const Map<String, dynamic> answersDict = {
  //   'Project Size': 'Small-Medium',
  //   'Project Type': 'Any',
  //   'Methodology': 'Iterative',
  //   'Flexibility': 'High',
  //   'Communication & Collaboration': 'Low',
  //   'Planning & Documentation': 'High',
  //   'Risk Management': 'High',
  //   'Quality Assurance': 'High',
  //   'Release Strategy': 'Continuous',
  //   'Customer Involvement': 'Medium',
  //   'Resource Management': 'High',
  //   'Metrics & Measurement': 'High',
  //   'Min Team Size': 5,
  //   'Max Team Size': 10,
  //   'Preferred Use Cases': 'High emphasis on testing',
  // };
  String? recommendedModel;

  Quiz({required this.answersDict, this.recommendedModel});

  // Getters and setters
  Map<String, dynamic> get getAnswers => answersDict;
  String? get getRecommendedModel => recommendedModel;
  // set recommendedModel(String? value) => recommendedModel = value;
  void setRecommendedModel(String? value) {
    recommendedModel = value;
    // print(recommendedModel);
  }

  // Other methods
  void editAnswer(String questionKey, dynamic answer) {
    answersDict[questionKey] = answer;
  }

  dynamic getAnswer(String questionKey) => answersDict[questionKey];

  // Fetches the CSV data from the Lambda function, calculates the nearest match
  // for the model based on the user's input, and sets the recommended model.
  Future<void> findRecommendedModel() async {
    final String lambdaUrl =
        'https://cg2k6m7ikvxgbgy7pcnlud3g5m0lnkyc.lambda-url.us-east-1.on.aws/';

    try {
      final response = await http.get(Uri.parse(lambdaUrl));
      if (response.statusCode == 200) {
        final List<List<dynamic>> rowsAsListOfValues =
            CsvToListConverter().convert(response.body);
        // Remove the header row
        rowsAsListOfValues.removeAt(0);
        rowsAsListOfValues.removeAt(14);

        int bestMatchIndex = -1;
        int bestMatchScore = -1;

        for (int i = 0; i < rowsAsListOfValues.length; i++) {
          final row = rowsAsListOfValues[i];
          print("First Row: ${row}\n\n");

          int score = 0;
          for (int j = 1; j < row.length - 1; j++) {
            // print("object:");
            // print(answersDict.values.elementAt(j));
            // print("Element: ${row[j]}\ninput: ${answersDict.values.elementAt(j-1)}");
            if (row[j] == answersDict.values.elementAt(j-1)) {
              score++;
            }
          }

          print("Bestmatchscore: $bestMatchScore\n Bestmatch index: $bestMatchIndex");
          if (score > bestMatchScore) {
            bestMatchScore = score;
            bestMatchIndex = i;
          }        }

        if (bestMatchIndex != -1) {
          setRecommendedModel(rowsAsListOfValues[bestMatchIndex][0]);
        } else {
          throw Exception('No model found');
        }
      } else {
        throw Exception('Failed to load CSV');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to find recommended model');
    }
  }
}
