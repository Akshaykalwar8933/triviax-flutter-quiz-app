import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app_pages.dart';
import 'app/bindings.dart';
import 'controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('customQuizBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController =
  Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
      themeMode: themeController.isDark.value
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor:
        Colors.grey.shade100,
      ),
      darkTheme: ThemeData.dark(),
    ));
  }
}
