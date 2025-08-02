import 'package:flutter/material.dart';
import 'package:todolist/utils/button.dart';

class DialogeBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogeBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 233, 186, 243),
      title: Text("Let's Get Things Done!   set your next move."),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(onPressed: onSave, text: "Save"),
                SizedBox(width: 8),
                MyButton(onPressed: onCancel, text: "cancel"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
