import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class InputChatbot extends StatelessWidget {
  const InputChatbot({
    super.key,
    required this.controller,
    required this.onSendMessage,
  });

  final TextEditingController controller;
  final Function(String) onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Upišite poruku...',
                hintStyle: AppTextStyles.chatInputMessages(context),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                suffixIcon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSurface,
              ),
              style: AppTextStyles.chatInputMessages(context),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => onSendMessage(controller.text),
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
