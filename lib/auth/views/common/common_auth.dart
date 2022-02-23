import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customdecoratedBox({
  required Widget child,
  Color? color,
  double? borderRadius,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      boxShadow: [
        BoxShadow(
          color: color ?? CupertinoColors.systemGrey.withOpacity(0.25),
          blurRadius: 1,
          spreadRadius: 1,
          offset: const Offset(2, 2),
        ),
        const BoxShadow(
          color: CupertinoColors.white,
          blurRadius: 1,
          spreadRadius: 1,
          offset: Offset(-2, -2),
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color ?? CupertinoColors.systemGrey.withOpacity(0.25),
          Colors.white,
        ],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
        decoration: BoxDecoration(
          color: color ?? CupertinoColors.systemGrey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
        child: child,
      ),
    ),
  );
}

customAlretDialog({
  required String title,
  required String message,
  required BuildContext context,
  void Function()? onPressed,
  String? buttonText,
}) {
  return showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: Text(buttonText ?? 'Ok'),
          onPressed: onPressed ?? () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
