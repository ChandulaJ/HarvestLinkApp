import 'system_user.dart';

class Customer extends SystemUser {
  String customerId;
  String name;
  String phoneNumber;
  String address;

  Customer(
      {required String userId,
      required String password,
      required bool loginStatus,
      required this.customerId,
      required this.name,
      required this.phoneNumber,
      required this.address})
      : super(userId: userId, password: password, loginStatus: loginStatus);

  void viewOrderHistory() {}
}
