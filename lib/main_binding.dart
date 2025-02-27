import 'package:app/controllers/authentication_controller.dart';
import 'package:app/controllers/poll_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController(), permanent: true);
    Get.put(PollController(), permanent: true);
  }
}
