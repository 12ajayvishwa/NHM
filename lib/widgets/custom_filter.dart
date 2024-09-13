import 'package:flutter/material.dart';

Future<dynamic> filterDialog(BuildContext context, Size size, child) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: child);
      });
}
