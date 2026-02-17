import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/admin_controller.dart';
import '../data/models/custom_mdoel.dart';

class AddQuestionView extends StatefulWidget {
  const AddQuestionView({super.key});

  @override
  State<AddQuestionView> createState() =>
      _AddQuestionViewState();
}

class _AddQuestionViewState
    extends State<AddQuestionView> {

  final AdminController adminController =
  Get.find<AdminController>();

  final TextEditingController questionController =
  TextEditingController();

  final List<TextEditingController>
  optionControllers =
  List.generate(
      4,
          (_) => TextEditingController());

  int correctIndex = -1;
  String difficulty = "easy";

  bool isEdit = false;
  int editIndex = -1;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;

    if (args != null &&
        args["isEdit"] == true) {

      isEdit = true;
      editIndex = args["index"];

      CustomQuestionModel q =
      args["question"];

      questionController.text =
          q.question;

      for (int i = 0;
      i < q.options.length;
      i++) {
        optionControllers[i].text =
        q.options[i];
      }

      correctIndex =
          q.correctIndex;
      difficulty =
          q.difficulty;
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            isEdit
                ? "Edit Question"
                : "Add Question"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            /// 🧠 QUESTION CARD
            _sectionTitle("Question"),

            const SizedBox(height: 10),

            Card(
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    16),
              ),
              child: Padding(
                padding:
                const EdgeInsets.all(
                    12),
                child: TextField(
                  controller:
                  questionController,
                  maxLines: 2,
                  decoration:
                  const InputDecoration(
                    border:
                    InputBorder.none,
                    hintText:
                    "Enter your question here",
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// 🎯 DIFFICULTY
            _sectionTitle(
                "Select Difficulty"),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: difficulty,
              decoration:
              InputDecoration(
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                      14),
                ),
                contentPadding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: [
                "easy",
                "medium",
                "hard"
              ]
                  .map((e) =>
                  DropdownMenuItem(
                    value: e,
                    child: Text(
                      e
                          .toUpperCase(),
                    ),
                  ))
                  .toList(),
              onChanged: (v) =>
              difficulty = v!,
            ),

            const SizedBox(height: 30),

            /// 📝 OPTIONS
            _sectionTitle(
                "Options (Select Correct One)"),

            const SizedBox(height: 15),

            ...List.generate(
              4,
                  (index) =>
                  _buildOptionCard(
                      index),
            ),

            const SizedBox(height: 40),

            /// 🚀 SAVE BUTTON
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
      String title) {

    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight:
        FontWeight.bold,
      ),
    );
  }

  // ============================================================
  // OPTION CARD
  // ============================================================

  Widget _buildOptionCard(
      int index) {

    final theme = Theme.of(context);

    final isSelected =
        correctIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          correctIndex = index;
        });
      },
      child: AnimatedContainer(
        duration:
        const Duration(
            milliseconds: 200),
        margin:
        const EdgeInsets.only(
            bottom: 14),
        padding:
        const EdgeInsets.all(14),
        decoration:
        BoxDecoration(
          color: isSelected
              ? Colors.green
              .withOpacity(
              0.15)
              : theme.cardColor,
          borderRadius:
          BorderRadius.circular(
              16),
          border: Border.all(
            color: isSelected
                ? Colors.green
                : Colors.grey
                .withOpacity(
                0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [

            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons
                  .radio_button_unchecked,
              color: isSelected
                  ? Colors.green
                  : Colors.grey,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: TextField(
                controller:
                optionControllers[
                index],
                decoration:
                InputDecoration(
                  border:
                  InputBorder.none,
                  hintText:
                  "Option ${index + 1}",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SAVE BUTTON
  // ============================================================

  Widget _buildSaveButton() {

    return GestureDetector(
      onTap: _saveQuestion,
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(
            vertical: 18),
        decoration:
        BoxDecoration(
          gradient:
          const LinearGradient(
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF357ABD),
            ],
          ),
          borderRadius:
          BorderRadius.circular(
              16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue
                  .withOpacity(0.3),
              blurRadius: 8,
              offset:
              const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            isEdit
                ? "Update Question"
                : "Save Question",
            style:
            const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SAVE LOGIC
  // ============================================================

  void _saveQuestion() {

    if (questionController
        .text
        .trim()
        .isEmpty) {
      Get.snackbar("Error",
          "Question cannot be empty");
      return;
    }

    if (correctIndex == -1) {
      Get.snackbar("Error",
          "Select correct answer");
      return;
    }

    for (var controller
    in optionControllers) {
      if (controller.text
          .trim()
          .isEmpty) {
        Get.snackbar("Error",
            "All options required");
        return;
      }
    }

    final q =
    CustomQuestionModel(
      question:
      questionController.text,
      options: optionControllers
          .map((e) => e.text)
          .toList(),
      correctIndex:
      correctIndex,
      difficulty:
      difficulty,
    );

    if (isEdit) {
      adminController
          .updateQuestion(
          editIndex, q);
    } else {
      adminController
          .addQuestion(q);
    }

    Get.back();
  }
}
