import 'package:softmodel/modelselection/domain/services/predictionmodel.dart';

class ModelsList {
  List<PredictionModel> modelList;

  ModelsList({required this.modelList});

  // Getters and setters
  List<PredictionModel> get getModelList => modelList;
  set setModelList(List<PredictionModel> value) => modelList = value;

  // Other methods
  void addModel(PredictionModel model) {
    modelList.add(model);
  }
}
