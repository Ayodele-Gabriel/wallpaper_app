import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/constants/app_assets.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  bool isFavorite(String id) => state.contains(id);

  void toggleFavorite(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  List<Map<String, dynamic>> getFavoriteWallpapers(
      List<Map<String, dynamic>> allWallpapers,
      ) {
    return allWallpapers.where((w) => state.contains(w['id'])).toList();
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
      (ref) => FavoritesNotifier(),
);

final List<Map<String, dynamic>> wallpaperData = [
{'id': 'nature_1', 'name': 'Nature 1', 'image': AppAssets.nature1},
{'id': 'nature_2', 'name': 'Nature 2', 'image': AppAssets.nature2},
{'id': 'nature_3', 'name': 'Nature 3', 'image': AppAssets.nature3},
{'id': 'nature_4', 'name': 'Nature 4', 'image': AppAssets.nature4},
{'id': 'nature_5', 'name': 'Nature 5', 'image': AppAssets.nature5},
{'id': 'nature_6', 'name': 'Nature 6', 'image': AppAssets.nature6},
];