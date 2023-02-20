import 'package:chatia/constant/app_common.dart';
import 'package:chatia/features/chat/widgets/send_message_button.dart';
import 'package:chatia/models/chat.dart';
import 'package:chatia/providers/chat_provider.dart';
import 'package:chatia/services/ai_chat_handler.dart';
import 'package:chatia/services/voice_record_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextVoiceMessageField extends ConsumerStatefulWidget {
  const TextVoiceMessageField({super.key});

  @override
  ConsumerState<TextVoiceMessageField> createState() =>
      _TextVoiceMessageFieldState();
}

class _TextVoiceMessageFieldState extends ConsumerState<TextVoiceMessageField> {
  final TextEditingController textMessageController = TextEditingController();
  InputMode mode = InputMode.voice;

  final AiChatHandle _aiChatHandle = AiChatHandle();
  final VoiceRecordHandle _voiceRecordHandle = VoiceRecordHandle();

  bool _isReplying = false;
  bool _isListening = false;

  @override
  void initState() {
    _voiceRecordHandle.initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    textMessageController.dispose();
    _aiChatHandle.dispose();
    super.dispose();
  }

  void addMessageToChatList(String message, bool isMe, String id) {
    final chats = ref.read(chatProvider.notifier);
    chats.add(
      Chat(id: id, message: message, isMe: isMe),
    );
  }

  void sendTextMessage(String message) async {
    setReplyingState(true);
    addMessageToChatList(message, true, DateTime.now().toString());
    addMessageToChatList("Typing...", false, 'wating');
    setState(() {
      mode = InputMode.voice;
    });
    final apiResponse = await _aiChatHandle.getResponse(message);
    removeTyping('wating');
    addMessageToChatList(apiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  void removeTyping(String id) {
    final chats = ref.read(chatProvider.notifier);
    chats.removeTyping(id);
  }

  void setReplyingState(bool state) {
    setState(() {
      _isReplying = state;
    });
  }

  void setListeningState(bool state) {
    setState(() {
      _isListening = state;
    });
  }

  void sendVoidMessage() async {
    if (!_voiceRecordHandle.isEnabled) {
      const SnackBar(content: Text("Device not supported !"));
      return null;
    }
    if (_voiceRecordHandle.speechToText.isListening) {
      _voiceRecordHandle.stopListening();
      setListeningState(false);
    } else {
      setListeningState(true);
      final result = await _voiceRecordHandle.startListening();
      setListeningState(false);
      sendTextMessage(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    mode = InputMode.text;
                  });
                } else {
                  setState(() {
                    mode = InputMode.voice;
                  });
                }
              },
              controller: textMessageController,
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: SendMessageButton(
                  isReplying: _isReplying,
                  inputMode: mode,
                  isListening: _isListening,
                  sendTextMessage: () {
                    final String msg =
                        textMessageController.text.trim().toString();
                    textMessageController.clear();
                    sendTextMessage(msg);
                  },
                  sendVoiceMessage: sendVoidMessage,
                ),
              ),
            ),
          ),
          // const AudioMessage()
        ],
      ),
    );
  }
}
