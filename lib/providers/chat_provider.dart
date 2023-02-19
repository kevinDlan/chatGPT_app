import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat.dart';

class ChatNotifier extends StateNotifier<List<Chat>> {
  ChatNotifier() : super([]);

  void add(Chat chat) {
    state = [...state, chat];
  }

  void removeTyping(String id) {
    state = state..removeWhere((chat) => chat.id == id);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<Chat>>(
  (ref) => ChatNotifier(),
);
