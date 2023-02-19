import 'package:chatia/constant/app_theme.dart';
import 'package:chatia/features/chat/screens/chat_screen.dart';
import 'package:chatia/providers/activate_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Themes appTheme = ref.watch(activateThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lighTheme,
      darkTheme: darkTheme,
      themeMode: appTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: const ChatScreen(),
    );
  }
}
