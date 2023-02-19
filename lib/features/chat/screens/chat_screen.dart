import 'package:chatia/features/chat/widgets/chat_item.dart';
import 'package:chatia/features/chat/widgets/custom_app_bar.dart';
import 'package:chatia/features/chat/widgets/text_voice_message_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat.dart';
import '../../../providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomeAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final List<Chat> chats =
                  ref.watch(chatProvider).reversed.toList();
              return chats.isNotEmpty
                  ? ListView.builder(
                      reverse: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final Chat chat = chats[index];
                        return ChatItem(message: chat.message, isMe: chat.isMe);
                      },
                    )
                  : const Center(
                      child: Text(
                        "Send Me Message To start Chat 😎",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    );
            }),
          ),
          const TextVoiceMessageField()
        ],
      ),
    );
  }
}
