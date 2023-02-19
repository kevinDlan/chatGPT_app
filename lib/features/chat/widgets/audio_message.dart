import 'package:flutter/material.dart';

class AudioMessage extends StatelessWidget {
  const AudioMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.mic,
        size: 30.0,
      ),
    );
  }
}
