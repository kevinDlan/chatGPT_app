import 'package:chatia/constant/app_common.dart';
import 'package:flutter/material.dart';

class SendMessageButton extends StatefulWidget {
  final InputMode _inputMode;
  final bool _isReplying;
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final bool _islistening;
  const SendMessageButton(
      {super.key,
      required inputMode,
      required isReplying,
      required isListening,
      required VoidCallback sendTextMessage,
      required VoidCallback sendVoiceMessage})
      : _inputMode = inputMode,
        _isReplying = isReplying,
        _islistening = isListening,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage;

  @override
  State<SendMessageButton> createState() => _SendMessageButtonState();
}

class _SendMessageButtonState extends State<SendMessageButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget._isReplying
          ? null
          : widget._inputMode == InputMode.text
              ? widget._sendTextMessage
              : widget._sendVoiceMessage,
      icon: widget._inputMode == InputMode.text
          ? Icon(
              Icons.send,
              size: 25,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : widget._islistening
              ? const Icon(Icons.mic_off)
              : const Icon(
                  Icons.mic,
                  size: 25.0,
                ),
    );
  }
}
