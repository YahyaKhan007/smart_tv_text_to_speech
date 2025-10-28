// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget body;
  final Widget? bottom;
  final Widget? fab;
  bool extendedBoyBehindAppBar;
  bool? top;

  BaseScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.bottom,
    this.fab,
    this.top,
    this.extendedBoyBehindAppBar = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ThemeController themeController = Get.find();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: extendedBoyBehindAppBar,
        appBar: appBar,
        drawer: drawer,
        body: SafeArea(top: top ?? false, child: body),
        floatingActionButton: fab,
        bottomNavigationBar: bottom,
      ),
    );
  }
}
