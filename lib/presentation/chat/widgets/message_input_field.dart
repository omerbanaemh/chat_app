import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const MessageInputField(
      {super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onSubmitted: (data) => onSend(),
        decoration: InputDecoration(
          hintText: 'Send Message',
          suffixIcon: IconButton(
            onPressed: onSend,
            icon: const Icon(Icons.send, color: kPrimaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
