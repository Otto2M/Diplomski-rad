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
          final messageText = message.values.first;

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
              child: messageText == 'loading'
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.amber,
                      ),
                    )
                  : Text(
                      messageText,
                      style: isUser
                          ? AppTextStyles.chatMessages(context)
                          : AppTextStyles.chatResponseMessages(context),
                    ),
            ),
          );
        },
      ),
    );
  }
}
