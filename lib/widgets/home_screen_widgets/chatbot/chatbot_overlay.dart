import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/services/flowise_service.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/chatbot/body_message_chatbot.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/chatbot/header_chatbot.dart';
import 'package:povedi_me_app/widgets/home_screen_widgets/chatbot/input_chatbot.dart';

class ChatBotOverlay extends StatefulWidget {
  const ChatBotOverlay({super.key});

  @override
  State<ChatBotOverlay> createState() => _ChatBotOverlayState();
}

class _ChatBotOverlayState extends State<ChatBotOverlay> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String message) async {
    if (message.isEmpty) return;

    final messageHr =
        "$message. Odgovaraj mi isključivo na hrvatskom jeziku i duljine oko 500 tokena.";

    FocusScope.of(context).unfocus();

    if (message.isEmpty) return;

    setState(() {
      _messages.add({'user': message});
      _messages.add({'bot': 'loading'});
    });

    _controller.clear();

    try {
      final responseText = await FlowiseService().queryFlowise(messageHr);

      setState(() {
        _messages.removeLast();
        _messages.add({'bot': responseText});
      });
    } catch (error) {
      setState(() {
        _messages.removeLast();
        _messages.add({
          'bot':
              'Došlo je do pogreške pri dohvaćanju odgovora. Pokušajte ponovo.'
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Center(
              child: FractionallySizedBox(
                heightFactor: 0.8,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: AppColors.darkBlue,
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      const HeaderChatbot(),

                      // // Messages
                      BodyMessageListChatbot(
                        messages: _messages,
                      ),

                      //Input
                      InputChatbot(
                        controller: _controller,
                        onSendMessage: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
