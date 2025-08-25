import 'package:flutter/material.dart';

import '../../utils/styles.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: AppStyles.normalTextStyle.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    ),
    backgroundColor: color ?? Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
