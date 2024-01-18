import 'system_user.dart';

class Farmer extends SystemUser {
  String farmerId;
  String name;
  String phoneNumber;
  String address;

  Farmer(
      {required String userId,
      required String password,
      required bool loginStatus,
      required this.farmerId,
      required this.name,
      required this.phoneNumber,
      required this.address})
      : super(userId: userId, password: password, loginStatus: loginStatus);

  void calEarnings() {}
}