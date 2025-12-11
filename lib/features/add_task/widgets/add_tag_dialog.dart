import 'package:flutter/material.dart';

void showAddTagDialog(BuildContext context, Function(String) onAdd) {
  showDialog(
    context: context,
    builder: (context) {
      String newTag = "";
      return AlertDialog(
        title: const Text("Add Tag"),
        content: TextField(
          autofocus: true,
          onChanged: (value) => newTag = value,
          decoration: const InputDecoration(hintText: "Enter tag name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (newTag.isNotEmpty) {
                onAdd(newTag);
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
