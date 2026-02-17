import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_controller.dart';
import '../data/models/questions_model.dart';
import '../data/models/custom_mdoel.dart';

class QuizView extends StatelessWidget {
  QuizView({super.key});

  final QuizController controller =
  Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TriviaX"),
        centerTitle: true,
      ),

      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.totalQuestions.value == 0) {
          return const Center(
            child: Text("No Questions Found"),
          );
        }

        late String questionText;
        late List<String> options;

        if (controller.quizType.value ==
            QuizType.api) {

          QuestionModel question =
          controller.apiQuestions[
          controller.currentIndex.value];

          questionText = question.question;
          options = question.options;

        } else {

          CustomQuestionModel question =
          controller.customQuestions[
          controller.currentIndex.value];

          questionText = question.question;
          options = question.options;
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              _buildTopSection(),

              const SizedBox(height: 20),

              /// 🧠 QUESTION CARD
              AnimatedSwitcher(
                duration:
                const Duration(
                    milliseconds: 300),
                child: Card(
                  key: ValueKey(
                      controller
                          .currentIndex
                          .value),
                  elevation: 8,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(18),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .all(24),
                    child: Text(
                      questionText,
                      textAlign:
                      TextAlign.center,
                      style: theme
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight:
                        FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// 🎯 OPTIONS
              Expanded(
                child: ListView.builder(
                  itemCount:
                  options.length,
                  itemBuilder:
                      (_, index) =>
                      _buildOptionTile(
                          options[index],
                          index),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ============================================================
  // 🔥 TOP SECTION (Progress + Score + Lives)
  // ============================================================

  Widget _buildTopSection() {

    return Obx(() {

      final progress =
          (controller.currentIndex.value + 1) /
              controller.totalQuestions.value;

      return Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          /// Progress + Counter
          Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            children: [

              Text(
                "Question ${controller.currentIndex.value + 1} / ${controller.totalQuestions.value}",
                style: const TextStyle(
                    fontWeight:
                    FontWeight.bold),
              ),

              Container(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration:
                BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                  BorderRadius
                      .circular(20),
                ),
                child: Obx(() => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    "Score: ${controller.score.value}",
                    key: ValueKey(controller.score.value),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ))

              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Progress Bar
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius:
            BorderRadius.circular(12),
          ),

          const SizedBox(height: 15),

          /// Lives
          Row(
            children: List.generate(
              3,
                  (index) => Padding(
                padding:
                const EdgeInsets
                    .only(right: 4),
                child: Icon(
                  Icons.favorite,
                  size: 24,
                  color: index <
                      controller
                          .lives
                          .value
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  // ============================================================
  // 🎯 OPTION TILE (Premium Design)
  // ============================================================

  Widget _buildOptionTile(
      String option, int index) {

    return Obx(() {

      Color backgroundColor =
          Get.theme.cardColor;

      Color textColor =
          Get.theme.textTheme.bodyLarge
              ?.color ??
              Colors.black;

      if (controller.isAnswered.value) {

        if (controller.quizType.value ==
            QuizType.api) {

          final q = controller
              .apiQuestions[
          controller
              .currentIndex
              .value];

          final correctIndex =
          q.options.indexOf(
              q.correctAnswer);

          if (index == correctIndex) {
            backgroundColor =
                Colors.green;
            textColor =
                Colors.white;
          } else if (index ==
              controller
                  .selectedIndex
                  .value) {
            backgroundColor =
                Colors.red;
            textColor =
                Colors.white;
          }

        } else {

          final q = controller
              .customQuestions[
          controller
              .currentIndex
              .value];

          if (index ==
              q.correctIndex) {
            backgroundColor =
                Colors.green;
            textColor =
                Colors.white;
          } else if (index ==
              controller
                  .selectedIndex
                  .value) {
            backgroundColor =
                Colors.red;
            textColor =
                Colors.white;
          }
        }
      }

      return AnimatedContainer(
        duration:
        const Duration(
            milliseconds: 250),
        margin:
        const EdgeInsets.only(
            bottom: 14),
        child: Material(
          borderRadius:
          BorderRadius.circular(
              16),
          elevation: 3,
          child: InkWell(
            borderRadius:
            BorderRadius.circular(
                16),
            onTap: controller
                .isAnswered
                .value ||
                controller
                    .lives
                    .value <=
                    0
                ? null
                : () => controller
                .selectAnswer(
                index),
            child: Container(
              padding:
              const EdgeInsets
                  .all(18),
              decoration:
              BoxDecoration(
                color:
                backgroundColor,
                borderRadius:
                BorderRadius
                    .circular(16),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
