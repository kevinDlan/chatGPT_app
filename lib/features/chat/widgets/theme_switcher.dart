import 'package:chatia/providers/activate_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  void toggleTheme({required WidgetRef ref, required bool switcherState}) {
    ref.read(activateThemeProvider.notifier).state =
        switcherState ? Themes.dark : Themes.light;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch.adaptive(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: ref.watch(activateThemeProvider) == Themes.dark ? true : false,
      onChanged: (value) => toggleTheme(ref: ref, switcherState: value),
    );
  }
}
