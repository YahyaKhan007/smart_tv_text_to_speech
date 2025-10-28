import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return CircularProgressIndicator(color: Colors.green);
    } else {
      return const CupertinoActivityIndicator();
    }
  }
}
