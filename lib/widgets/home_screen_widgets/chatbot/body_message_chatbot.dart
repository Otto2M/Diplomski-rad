import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class BodyMessageListChatbot extends StatelessWidget {
  const BodyMessageListChatbot({
    super.key,
    required this.messages,
  });

  final List<Map<String, String>> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isUser = message.containsKey('user');
          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context).colorScheme.onSecondary
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(message.values.first,
                  style: isUser
                      ? AppTextStyles.chatMessages(context)
                      : AppTextStyles.chatResponseMessages(context)),
            ),
          );
        },
      ),
    );
  }
}
