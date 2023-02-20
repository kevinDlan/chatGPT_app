import 'package:chatia/features/chat/widgets/chat_item.dart';
import 'package:chatia/features/chat/widgets/custom_app_bar.dart';
import 'package:chatia/features/chat/widgets/text_voice_message_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat.dart';
import '../../../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    return Scaffold(
      appBar: const CustomeAppBar(),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/human.png'),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                ListTile(
                  onTap: () {
                    print("Logout");
                  },
                  leading: Icon(
                    Icons.person,
                    size: 30.0,
                  ),
                  title: Align(
                    alignment: Alignment(-1.3, 0),
                    child: Text(
                      'Profil',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print("Logout");
                  },
                  leading: Icon(
                    Icons.settings,
                    size: 30.0,
                  ),
                  title: Align(
                    alignment: Alignment(-1.3, 0),
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print("Logout");
                  },
                  leading: Icon(
                    Icons.history,
                    size: 30.0,
                  ),
                  title: Align(
                    alignment: Alignment(-1.3, 0),
                    child: Text(
                      'Chat History',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              onTap: () {
                print("Logout");
              },
              leading: Icon(
                Icons.logout,
                size: 30.0,
              ),
              title: Align(
                alignment: Alignment(-1.5, 0),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final List<Chat> chats =
                  ref.watch(chatProvider).reversed.toList();
              return chats.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
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
