import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

final clearBrowseStackProvider = StateProvider<bool>((ref) => false);
final browseCategoriesNavigationProvider = StateProvider<bool>((ref) => false);
final selectedWallpaperProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

