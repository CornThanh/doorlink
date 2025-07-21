import 'package:flutter/material.dart';

Future customSnackbar(
  BuildContext context,
  String subtitle,
  Color bgColor,
) async {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
    ),
  );
}
