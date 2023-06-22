import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

Future<void> ShowNoConnectionToast(
  String message,
  BuildContext context,
) async {
  await showFlash(
    context: context,
    duration: const Duration(seconds: 4),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        alignment: const Alignment(0, 0),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.black.withOpacity(0.7),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      );
    },
  );
}
