import 'package:softmodel/modelselection/domain/services/predictionmodel.dart';
import 'package:softmodel/modelselection/domain/services/quiz.dart';

class RecommendationList {
  List<PredictionModel> recommendationsList;


  RecommendationList({required this.recommendationsList});

  // Getters and setters
  List<PredictionModel> get getRecommendationsList => recommendationsList;
  set setRecommendationsList(List<PredictionModel> value) => recommendationsList = value;

  // Other methods
  void addRecommendation(PredictionModel recommendation) {
    recommendationsList.add(recommendation);
    //TODO: Find a way to add it to a file
  }
}
