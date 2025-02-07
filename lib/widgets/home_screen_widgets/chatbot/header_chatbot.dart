import 'package:flutter/material.dart';
import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class HeaderChatbot extends StatelessWidget {
  const HeaderChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dobrodošli!',
                style: AppTextStyles.chatHeadline(context),
              ),
              Text(
                'Kako Vam možemo pomoći?',
                style: AppTextStyles.chatMessages(context),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: IconButton(
              icon: Image.asset(
                Assets.iRedX,
                color: Theme.of(context).colorScheme.surface,
                scale: MediaQuery.devicePixelRatioOf(context) * 15,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // const Icon(
            //   Icons.close,
            //   color: Colors.white,
            // ),
          ),
        ],
      ),
    );
  }
}
