class PredictionModel {
  String modelName;
  String modelDescription;
  String modelLogo;
  String modelBestUse;

  PredictionModel({
    required this.modelName,
    required this.modelDescription,
    required this.modelLogo,
    required this.modelBestUse,
  });

  // Getters and setters
  String get getModelName => modelName;
  set setModelName(String value) => modelName = value;

  String get getModelDescription => modelDescription;
  set setModelDescription(String value) => modelDescription = value;

  String get getModelLogo => modelLogo;
  set setModelLogo(String value) => modelLogo = value;

  String get getModelBestUse => modelBestUse;
  set setModelBestUse(String value) => modelBestUse = value;
}
