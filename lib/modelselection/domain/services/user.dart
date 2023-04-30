class User {
  String userName;
  String userEmail;
  String userPassword;
  String userPhoto;
  List<String> accessList;

  User({
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhoto,
    required this.accessList,
  });

  // Getters and setters
  String get getUserName => userName;
  set setUserName(String value) => userName = value;

  String get getUserEmail => userEmail;
  set setUserEmail(String value) => userEmail = value;

  String get getUserPassword => userPassword;
  set setUserPassword(String value) => userPassword = value;

  String get getUserPhoto => userPhoto;
  set setUserPhoto(String value) => userPhoto = value;

  List<String> get getAccessList => accessList;
  set setAccessList(List<String> value) => accessList = value;

  bool checkAccessTo(String access) => accessList.contains(access);

  void editAccessTo(String access, bool grantAccess) {
    if (grantAccess && !accessList.contains(access)) {
      accessList.add(access);
    } else if (!grantAccess && accessList.contains(access)) {
      accessList.remove(access);
    }
  }
}
