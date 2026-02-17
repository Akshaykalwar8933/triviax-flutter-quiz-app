import 'package:get/get.dart';
import '../app/routes.dart';
import '../data/models/custom_mdoel.dart';
import '../data/models/questions_model.dart';
import '../data/services/quiz_service.dart';

enum QuizType { api, custom }

class QuizController extends GetxController {
  final QuizService _service = QuizService();

  Rx<QuizType> quizType = QuizType.api.obs;

  RxList<QuestionModel> apiQuestions = <QuestionModel>[].obs;

  RxList<CustomQuestionModel> customQuestions = <CustomQuestionModel>[].obs;

  RxInt currentIndex = 0.obs;
  RxInt score = 0.obs;
  RxInt lives = 3.obs;

  RxBool isLoading = false.obs;
  RxBool isAnswered = false.obs;
  RxInt selectedIndex = (-1).obs;

  RxInt totalQuestions = 0.obs;
  RxString difficulty = ''.obs;

  void resetQuiz() {
    currentIndex.value = 0;
    score.value = 0;
    lives.value = 3;
    isAnswered.value = false;
    selectedIndex.value = -1;
  }

  Future<void> loadApiQuiz({
    required int limit,
    required String difficulty,
  }) async {
    resetQuiz();
    quizType.value = QuizType.api;
    this.difficulty.value = difficulty;

    try {
      isLoading.value = true;

      apiQuestions.value = await _service.fetchQuestions(
        limit: limit,
        difficulty: difficulty,
      );

      totalQuestions.value = apiQuestions.length;
    } finally {
      isLoading.value = false;
    }
  }

  void loadCustomQuiz(List<CustomQuestionModel> list) {
    resetQuiz();
    quizType.value = QuizType.custom;

    customQuestions.value = List.from(list)..shuffle();

    totalQuestions.value = customQuestions.length;
  }

  // void selectAnswer(int index) {
  //
  //   if (isAnswered.value) return;
  //
  //   selectedIndex.value = index;
  //   isAnswered.value = true;
  //
  //   bool isCorrect = false;
  //
  //   if (quizType.value == QuizType.api) {
  //
  //     final question =
  //     apiQuestions[currentIndex.value];
  //
  //     isCorrect =
  //         question.options[index] ==
  //             question.correctAnswer;
  //
  //   } else {
  //
  //     final question =
  //     customQuestions[currentIndex.value];
  //
  //     isCorrect =
  //         index == question.correctIndex;
  //   }
  //
  //   if (isCorrect) {
  //     score.value += 10;
  //   } else {
  //     lives.value -= 1;
  //   }
  //
  //   Future.delayed(
  //       const Duration(milliseconds: 800),
  //           () {
  //         _goToNext();
  //       });
  // }


  void selectAnswer(int index) {

    if (isAnswered.value) return;

    selectedIndex.value = index;
    isAnswered.value = true;

    if (quizType.value == QuizType.api) {

      final question =
      apiQuestions[currentIndex.value];

      final correctIndex =
      question.options.indexOf(
          question.correctAnswer);

      if (index == correctIndex) {
        score.value += 10;   // ✅ FIXED
      } else {
        lives.value -= 1;
      }

    } else {

      final question =
      customQuestions[currentIndex.value];

      if (index == question.correctIndex) {
        score.value += 10;   // ✅ FIXED
      } else {
        lives.value -= 1;
      }
    }

    /// Small delay to show color before moving
    Future.delayed(
      const Duration(milliseconds: 700),
      nextQuestion,
    );
  }


  void _goToNext() {

    if (lives.value <= 0) {
      Get.offAllNamed(AppRoutes.RESULT);
      return;
    }

    if (currentIndex.value <
        totalQuestions.value - 1) {

      /// 🔥 RESET FIRST
      isAnswered.value = false;
      selectedIndex.value = -1;

      /// THEN CHANGE QUESTION
      currentIndex.value++;

    } else {
      Get.offAllNamed(AppRoutes.RESULT);
    }
  }

  void nextQuestion() {
    if (lives.value <= 0) {
      Get.offAllNamed(AppRoutes.RESULT);
      return;
    }

    if (currentIndex.value < totalQuestions.value - 1) {
      currentIndex.value++;
      isAnswered.value = false;
      selectedIndex.value = -1;
    } else {
      Get.offAllNamed(AppRoutes.RESULT);
    }
  }

  Future<void> restartQuiz() async {
    if (quizType.value == QuizType.api) {
      await loadApiQuiz(
        limit: totalQuestions.value,
        difficulty: difficulty.value,
      );
    } else {
      loadCustomQuiz(customQuestions);
    }
  }
}
