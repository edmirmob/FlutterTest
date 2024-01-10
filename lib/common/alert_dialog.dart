import 'package:flutter/material.dart';

import 'current_context.dart';

Future<void> showAlertDialog(
  String title,
  String message,
) {
  final theme = Theme.of(getCurrentContext()!);
  return showDialog(
    context: getCurrentContext()!,
    builder: (ctx) {
      return PopScope(
        onPopInvoked: (value) => Future.value(false),
        child: AlertDialog(
          title: Text(title,
              style: theme.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 17)),
          content: Text(message,
              style: theme.textTheme.bodyText1!.copyWith(fontSize: 16)),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(theme.colorScheme.secondary),
              ),
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    },
  );
}
