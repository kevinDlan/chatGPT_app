import 'package:chatia/features/chat/widgets/theme_switcher.dart';
import 'package:chatia/providers/activate_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Chat',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      actions: [
        Row(
          children: [
            Consumer(builder: (context, ref, child) {
              return Icon(ref.watch(activateThemeProvider) == Themes.dark
                  ? Icons.dark_mode
                  : Icons.light_mode);
            }),
            const ThemeSwitcher()
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
