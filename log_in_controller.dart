import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;

  var mobileNo = "".obs;
  var otp = "".obs;

  var email = "".obs;
  var password = "".obs;

  var hidePassword = true.obs;

  var isLoading = true.obs;
}