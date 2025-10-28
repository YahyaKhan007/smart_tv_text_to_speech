import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tv_project/src/core/utills/custom_elements/custom_text.dart';
import 'package:tv_project/src/modules/home_module/controller/home_screen_controller.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late Stream<DateTime> _timeStream;
  HomeScreenController homeController = Get.find<HomeScreenController>();

  @override
  void initState() {
    _timeStream = homeController.getTimeStream();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      await homeController.getAllRoomTokens();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TOP ROW WHERE WE SHOW THE ROOM NUMBER  &&  TIME
          topRow(),

          // Middle ROW WHERE WE SHOW THE DATA  &&  NUMBER
          Expanded(child: Obx(() => MiddleDataRow())),
        ],
      ),
    );
  }

  Widget topRow() {
    return Container(
      color: Colors.grey.shade200,
      height: 80,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: CustomText(
              text: 'Male MO Room 4',
              fontSize: 32,
              textColor: Colors.green,
              fontWeight: FontWeight.bold,
            ).paddingOnly(left: 8),
          ),
          // TIME AND DATE SECTION
          Expanded(
            flex: 3,
            child: StreamBuilder<DateTime>(
              stream: _timeStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();

                final now = snapshot.data!;
                final time = DateFormat('hh:mm:ss a').format(now);
                final date = DateFormat('EEE dd MMM, yyyy').format(now);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: time,
                      fontSize: 24,
                      textColor: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      // text: 'Mon 22 sep, 2025',
                      text: date,
                      fontSize: 20,
                      textColor: Colors.grey.shade800,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget MiddleDataRow() {
    log('✅ FROM HOME Successfully parsed ${homeController.allRoomTokens.length} tokens');

    return Row(
      children: [
        Expanded(
          flex: 7,
          child: ListView.builder(
            itemCount: homeController.allRoomTokens.length,
            itemBuilder: (context, index) {
              final singleRoomToken = homeController.allRoomTokens[index];
              return Container(
                color: index == 0 ? Colors.green : Colors.grey.shade200,
                height: 100,
                width: double.infinity,
                child: Center(
                  child: ListTile(
                    leading: CustomText(
                      text: '${singleRoomToken.visitNo}',
                      fontSize: 24,
                      textColor: index != 0 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    title: CustomText(
                      text: "Male MO Room ${index + 4}",
                      fontSize: 24,
                      textColor: index != 0 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.green,
            height: double.infinity,
            child: Center(
              child: CustomText(
                text: '29',
                fontSize: 200,
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
