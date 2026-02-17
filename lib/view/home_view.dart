import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes.dart';
import '../controller/admin_controller.dart';
import '../controller/quiz_controller.dart';
import '../controller/theme_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AdminController adminController =
  Get.find<AdminController>();

  final QuizController quizController =
  Get.find<QuizController>();

  final ThemeController themeController =
  Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TriviaX"),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              themeController.isDark.value
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed:
            themeController.toggleTheme,
          ))
        ],
      ),

      body: Center(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [

              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.quiz,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Welcome to TriviaX",
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Challenge yourself with API & Custom quizzes.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              _mainButton(
                text: "Play API Quiz",
                icon: Icons.public,
                onTap: () async {
                  await quizController.loadApiQuiz(
                      limit: 10,
                      difficulty: "easy");
                  Get.toNamed(AppRoutes.QUIZ);
                },
              ),

              const SizedBox(height: 20),

              _mainButton(
                text: "Play Custom Quiz",
                icon: Icons.edit_note,
                onTap: () {
                  if (adminController
                      .customQuestions
                      .isEmpty) {
                    Get.snackbar(
                        "Empty",
                        "No custom questions found");
                    return;
                  }
                  quizController.loadCustomQuiz(
                      adminController
                          .customQuestions);
                  Get.toNamed(AppRoutes.QUIZ);
                },
              ),

              const SizedBox(height: 20),

              OutlinedButton.icon(
                icon: const Icon(
                    Icons.admin_panel_settings),
                label: const Text("Admin Panel"),
                onPressed: () =>
                    Get.toNamed(AppRoutes.ADMIN),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(
            vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF357ABD),
            ],
          ),
          borderRadius:
          BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: Colors.white),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
