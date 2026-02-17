import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../controller/admin_controller.dart';
import '../app/routes.dart';

class AdminView extends StatelessWidget {
  AdminView({super.key});

  final AdminController controller =
  Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final isDark =
        theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () =>
            Get.toNamed(
                AppRoutes.ADD_QUESTION),
        child: const Icon(Icons.add),
      ),

      body: Obx(() {

        if (controller
            .customQuestions
            .isEmpty) {
          return Center(
            child: Text(
              "No Questions Added",
              style: theme
                  .textTheme.titleMedium,
            ),
          );
        }

        return ListView.builder(
          padding:
          const EdgeInsets.all(16),
          itemCount:
          controller.customQuestions.length,
          itemBuilder:
              (_, index) {

            final q = controller
                .customQuestions[index];

            return Container(
              margin:
              const EdgeInsets.only(
                  bottom: 14),
              padding:
              const EdgeInsets.all(
                  16),
              decoration:
              BoxDecoration(
                color:
                theme.cardColor,
                borderRadius:
                BorderRadius
                    .circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black
                        .withOpacity(
                        0.3)
                        : Colors.grey
                        .withOpacity(
                        0.2),
                    blurRadius: 8,
                    offset:
                    const Offset(
                        0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [

                  /// Question Number + Actions
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [

                      Text(
                        "Q${index + 1}",
                        style: theme
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),

                      _buildActionMenu(
                          index, q),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Question Text
                  Text(
                    q.question,
                    style: theme
                        .textTheme
                        .bodyLarge,
                  ),

                  const SizedBox(height: 8),

                  /// Difficulty Badge
                  Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration:
                    BoxDecoration(
                      color: _difficultyColor(
                          q.difficulty),
                      borderRadius:
                      BorderRadius
                          .circular(
                          20),
                    ),
                    child: Text(
                      q.difficulty
                          .toUpperCase(),
                      style:
                      const TextStyle(
                        color:
                        Colors.white,
                        fontSize: 12,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  // ============================================================
  // ACTION DROPDOWN (EDIT / DELETE)
  // ============================================================

  Widget _buildActionMenu(
      int index, dynamic q) {

    final theme = Get.theme;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(

        customButton: const Icon(
          Icons.more_vert,
        ),

        // useRootNavigator: true,

        items: [
          DropdownMenuItem(
            value: "edit",
            child: Row(
              children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text("Edit"),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "delete",
            child: Row(
              children: const [
                Icon(Icons.delete,
                    size: 18,
                    color: Colors.red),
                SizedBox(width: 8),
                Text("Delete"),
              ],
            ),
          ),
        ],

        onChanged: (value) {

          if (value == "edit") {

            Get.toNamed(
              AppRoutes.ADD_QUESTION,
              arguments: {
                "isEdit": true,
                "index": index,
                "question": q,
              },
            );

          } else if (value == "delete") {

            _confirmDelete(index);
          }
        },

        dropdownStyleData: DropdownStyleData(
          width: 140,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius:
            BorderRadius.circular(12),
          ),
          elevation: 8,
        ),

        buttonStyleData: const ButtonStyleData(
          padding:
          EdgeInsets.symmetric(
              horizontal: 8),
        ),

        menuItemStyleData:
        const MenuItemStyleData(
          padding:
          EdgeInsets.symmetric(
              horizontal: 12),
        ),
      ),
    );
  }


  // ============================================================
  // DELETE CONFIRMATION
  // ============================================================

  void _confirmDelete(int index) {

    Get.dialog(
      AlertDialog(
        title:
        const Text("Delete Question"),
        content: const Text(
            "Are you sure you want to delete this question?"),
        actions: [
          TextButton(
            onPressed:
                () => Get.back(),
            child:
            const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              controller
                  .deleteQuestion(
                  index);
              Get.back();
            },
            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              Colors.red,
            ),
            child:
            const Text("Delete"),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIFFICULTY COLOR
  // ============================================================

  Color _difficultyColor(
      String difficulty) {

    switch (difficulty) {
      case "easy":
        return Colors.green;
      case "medium":
        return Colors.orange;
      case "hard":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
