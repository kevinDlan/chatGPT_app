import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<Themes> activateThemeProvider = StateProvider<Themes>(
  (ref) => Themes.dark,
);

enum Themes { light, dark }
