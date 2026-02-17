import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_controller.dart';
import '../app/routes.dart';

class ResultView extends StatelessWidget {
  ResultView({super.key});

  final QuizController controller =
  Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        automaticallyImplyLeading:
        false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment
              .center,
          children: [

            const Icon(
              Icons.emoji_events,
              size: 80,
              color: Colors.amber,
            ),

            const SizedBox(height: 20),

            Obx(() => Text(
              "Score: ${controller.score.value}",
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold),
            )),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await controller
                    .restartQuiz();
                Get.offAllNamed(
                    AppRoutes.QUIZ);
              },
              child:
              const Text("Play Again"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () {
                controller
                    .resetQuiz();
                Get.offAllNamed(
                    AppRoutes.HOME);
              },
              child:
              const Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}
