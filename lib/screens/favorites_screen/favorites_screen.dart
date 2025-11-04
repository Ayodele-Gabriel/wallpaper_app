import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_studio/utilities/providers/providers.dart';

import '../../utilities/constants/app_assets.dart';
import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/app_text.dart';
import '../../utilities/screen_sizing/screen_sizing.dart';
import '../../utilities/widgets/app_button.dart';
import '../../utilities/widgets/grid_card_widget.dart';
import '../../utilities/widgets/rainbow_text.dart';
import 'favorites_notifier/favorites_notifier.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDesktop = ScreenSizing.isDesktop(context);
    final favorites = ref.watch(favoritesProvider);
    final favoriteWallpapers =
    wallpaperData.where((w) => favorites.contains(w['id'])).toList();
    final hasFavorites = favoriteWallpapers.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RainbowText('Saved Wallpapers'),
                  // Optional: Show count
                  if (hasFavorites)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.rainbowTextColor1,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${favoriteWallpapers.length}',
                        style: AppText.appName.copyWith(
                          color: AppColors.baseWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                'Your saved wallpapers collection',
                style: AppText.appName.copyWith(
                  fontSize: 24.0,
                  color: AppColors.appGrey2,
                ),
              ),
            ],
          ),
          SizedBox(height: 50.0),
          hasFavorites
              ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favoriteWallpapers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 6 : 3,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final wallpaper = favoriteWallpapers[index];
              return CategoriesGrid(
                image: wallpaper['image'],
                textNumber: wallpaper['name'],
                isFavorite: true,
                onTap: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(wallpaper['id']);
                },
              );
            },
          )
              : Center(
            child: Column(
              children: [
                SvgPicture.asset(AppAssets.empty),
                SizedBox(height: 50.0),
                Text(
                  'No Saved Wallpapers',
                  style: AppText.cardText2.copyWith(
                    fontSize: 24.0,
                    color: AppColors.appGrey2,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Start saving your favorite wallpapers to see them here',
                  style: AppText.appName.copyWith(color: AppColors.appGrey2),
                ),
                SizedBox(height: 30.0),
                AppButton(
                  width: 250.0,
                  color: AppColors.rainbowTextColor1,
                  onPressed: () {
                    ref.watch(navigationIndexProvider.notifier).state = 1;
                  },
                  child: Text(
                    'Browse Wallpapers',
                    style: AppText.appName.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.baseWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}