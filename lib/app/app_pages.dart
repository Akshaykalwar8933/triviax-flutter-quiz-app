import 'package:get/get.dart';
import '../view/add_question_view.dart';
import '../view/admin_view.dart';
import '../view/home_view.dart';
import '../view/quiz_view.dart';
import '../view/result_view.dart';
import 'routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.HOME, page: () => HomeView()),
    GetPage(name: AppRoutes.QUIZ, page: () => QuizView()),
    GetPage(name: AppRoutes.RESULT, page: () => ResultView()),
    GetPage(name: AppRoutes.ADMIN, page: () => AdminView()),
    GetPage(name: AppRoutes.ADD_QUESTION, page: () => AddQuestionView()),
  ];
}
