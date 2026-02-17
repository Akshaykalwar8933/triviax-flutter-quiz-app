import 'package:get/get.dart';
import '../controller/admin_controller.dart';
import '../controller/quiz_controller.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(QuizController(), permanent: true);
    Get.put(AdminController(), permanent: true);
  }
}
