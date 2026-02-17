import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../data/models/custom_mdoel.dart';

class AdminController extends GetxController {

  final box = Hive.box('customQuizBox');

  RxList<CustomQuestionModel> customQuestions =
      <CustomQuestionModel>[].obs;

  int maxQuestions = 10;

  @override
  void onInit() {
    super.onInit();
    loadFromHive();
  }

  void loadFromHive() {
    final List data =
    box.get('questions', defaultValue: []);

    customQuestions.value = data
        .map((e) =>
        CustomQuestionModel.fromMap(
            Map<String, dynamic>.from(e)))
        .toList();
  }

  void saveToHive() {
    box.put(
      'questions',
      customQuestions
          .map((e) => e.toMap())
          .toList(),
    );
  }


  void addQuestion(CustomQuestionModel q) {
    if (customQuestions.length >= maxQuestions) {
      Get.snackbar(
          "Limit", "Maximum 10 questions allowed");
      return;
    }

    customQuestions.add(q);
    saveToHive();
  }

  void updateQuestion(
      int index,
      CustomQuestionModel q) {
    customQuestions[index] = q;
    saveToHive();
  }

  void deleteQuestion(int index) {
    customQuestions.removeAt(index);
    saveToHive();
  }
}
