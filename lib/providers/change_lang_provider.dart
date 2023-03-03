import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<Languages> appDefaultLocal =
    StateProvider<Languages>((ref) => Languages.en);

enum Languages { en, fr }
