import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_alice/alice.dart';
import 'package:tv_project/src/core/setting_up_things.dart';
import 'package:tv_project/src/modules/home_module/controller/home_screen_controller.dart';
import 'package:tv_project/src/modules/home_module/home_views.dart';
import 'package:overlay_support/overlay_support.dart';

var prefs;
final navigatorKey = GlobalKey<NavigatorState>();
final alice = Alice(navigatorKey: navigatorKey);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Firebase is initialized
  prefs = await SharedPreferences.getInstance();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await settingUpThings();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child:
          // Obx(
          //   () =>
          GetMaterialApp(
            initialBinding: AppBindings(),
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
            home: const HomeScreenView(),
            // ),
          ),
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
