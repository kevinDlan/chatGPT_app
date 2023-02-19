import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class AiChatHandle {
  final OpenAI _openAI = OpenAI.instance.build(
    token: chatGptApiKey,
    baseOption: HttpSetup(receiveTimeout: 20000),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = CompleteText(prompt: message, model: kTranslateModelV3);
      final response = await _openAI.onCompleteText(request: request);
      if (response != null) {
        return response.choices[0].text.trim();
      }
      return 'Something went wrong, Please Try Later.';
    } catch (e) {
      const SnackBar(
        content: Text('Something Wrong'),
      );
      print(e.toString());
    }
    return 'Something Wrong';
  }

  void dispose() {
    _openAI.close();
  }
}
