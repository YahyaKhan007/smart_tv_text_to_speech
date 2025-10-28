// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class heightBox extends StatelessWidget {
  double height;
  heightBox({super.key,required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class widthBox extends StatelessWidget {
 final double width;
 const widthBox({super.key,required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}

String formatTimestamp(int timestamp, String format) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}
