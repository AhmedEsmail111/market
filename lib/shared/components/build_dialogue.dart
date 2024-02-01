import 'package:flutter/material.dart';

void buildDialogue(
    {required BuildContext context,
    required String message,
    required String title,
    String undoText = 'cancel',
    String doText = 'Delete',
    void Function()? onDelete}) {
  final dialogue = AlertDialog(
    scrollable: true,
    title: Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    ),
    content: Center(
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary),
        child: Text(undoText),
      ),
      TextButton(
        onPressed: onDelete,
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError),
        child: Text(
          doText,
        ),
      ),
    ],
    actionsAlignment: MainAxisAlignment.center,
  );

  showDialog(
    context: context,
    builder: (context) {
      return dialogue;
    },
  );
}
