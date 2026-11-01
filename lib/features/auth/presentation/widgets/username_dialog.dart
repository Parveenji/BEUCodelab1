import 'package:flutter/material.dart';

class UsernameDialog extends StatelessWidget {
  const UsernameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    return AlertDialog(
      title: const Text("Enter Your Leetcode Username"),
      content: TextField(
        controller: usernameController,
        decoration: const InputDecoration(
          labelText: "Username",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final username = usernameController.text.trim();
            if (username.isNotEmpty) {
              Navigator.of(context).pop(username); // Return username
            }
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
