import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/constants/app_assets.dart';
import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/app_text.dart';
import '../../utilities/providers/providers.dart';
import '../../utilities/screen_sizing/screen_sizing.dart';
import '../../utilities/widgets/app_button.dart';
import '../../utilities/widgets/categories_drawer.dart';
import '../../utilities/widgets/grid_card_widget.dart';
import '../../utilities/widgets/list_card_widget.dart';
import '../favorites_screen/favorites_notifier/favorites_notifier.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  bool toggle = false;
  bool showCategoriesDrawer = false;
  int? selectedIndex;

  // Updated with IDs
  final List<Map<String, dynamic>> wallpaperData = [
    {'id': 'nature_1', 'name': 'Nature 1', 'image': AppAssets.nature1},
    {'id': 'nature_2', 'name': 'Nature 2', 'image': AppAssets.nature2},
    {'id': 'nature_3', 'name': 'Nature 3', 'image': AppAssets.nature3},
    {'id': 'nature_4', 'name': 'Nature 4', 'image': AppAssets.nature4},
    {'id': 'nature_5', 'name': 'Nature 5', 'image': AppAssets.nature5},
    {'id': 'nature_6', 'name': 'Nature 6', 'image': AppAssets.nature6},
  ];

  _onWallpaperSelected(WidgetRef ref, int index) {
    setState(() {
      selectedIndex = index;
    });
    ref.read(selectedWallpaperProvider.notifier).state = wallpaperData[index];
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenSizing.isDesktop(context);
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 5.0),
                          Text(
                            'Back to Categories',
                            style: AppText.appName.copyWith(
                              fontSize: 20.0,
                              color: AppColors.appGrey4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nature', style: AppText.bigText),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggle = !toggle;
                            });
                          },
                          child: SvgPicture.asset(toggle ? AppAssets.gridview : AppAssets.listview),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    !toggle
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: wallpaperData.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 3 : 2,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              final wallpaper = wallpaperData[index];
                              return Consumer(
                                builder: (context, ref, child) {
                                  final favorites = ref.watch(favoritesProvider);
                                  final isFavorite = favorites.contains(wallpaper['id']);

                                  return GestureDetector(
                                    onTap: () => _onWallpaperSelected(ref, index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: selectedIndex == index
                                            ? Border.all(
                                                color: AppColors.rainbowTextColor1,
                                                width: 3,
                                              )
                                            : null,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: CategoriesGrid(
                                        image: wallpaper['image'],
                                        textNumber: wallpaper['name'],
                                        isFavorite: isFavorite,
                                        onTap: () {
                                          ref
                                              .read(favoritesProvider.notifier)
                                              .toggleFavorite(wallpaper['id']);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: wallpaperData.length,
                            itemBuilder: (context, index) {
                              final wallpaper = wallpaperData[index];
                              return Consumer(
                                builder: (context, ref, child) {
                                  final favorites = ref.watch(favoritesProvider);
                                  final isFavorite = favorites.contains(wallpaper['id']);

                                  return GestureDetector(
                                    onTap: () => _onWallpaperSelected(ref, index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? AppColors.appGrey3.withAlpha((0.1 * 250).toInt())
                                            : null,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          CategoriesList(
                                            image: wallpaper['image'],
                                            textNumber: wallpaper['name'],
                                            isFavorite: isFavorite,
                                            onTap: () {
                                              ref
                                                  .read(favoritesProvider.notifier)
                                                  .toggleFavorite(wallpaper['id']);
                                            },
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(width: 30.0),

              isDesktop ? _desktopLayout() : _tabletLayout(),
            ],
          ),
        ),
        CategoriesDrawer(
          isVisible: showCategoriesDrawer,
          onClose: () {
            setState(() => showCategoriesDrawer = false);
          },
        ),
      ],
    );
  }

  Widget _tabletLayout() {
    return Consumer(
      builder: (context, ref, child) {
        final selectedWallpaper = ref.watch(selectedWallpaperProvider);
        final favorites = ref.watch(favoritesProvider);

        if (selectedWallpaper == null) {
          return Expanded(
            child: Center(
              child: Text(
                'Select a wallpaper to preview',
                style: AppText.appName.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        final isFavorite = favorites.contains(selectedWallpaper['id']);
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.baseWhite,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 258.03,
                height: 524.99,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.asset(
                        width: 258.03,
                        height: 524.99,
                        selectedWallpaper['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 72.36,
                          height: 20.88,
                          decoration: BoxDecoration(
                            color: AppColors.baseBlack,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 84.05,
                          height: 2.54,
                          decoration: BoxDecoration(
                            color: AppColors.baseWhite,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Text('Preview', style: AppText.cardText3.copyWith(fontSize: 32.0)),
                  SizedBox(height: 30.0),
                  Text('Name', style: AppText.appName.copyWith(color: AppColors.appGrey5)),
                  Text(
                    selectedWallpaper['name'],
                    style: AppText.cardText2.copyWith(fontSize: 24.0),
                  ),
                  SizedBox(height: 30.0),
                  Text('Tags', style: AppText.appName.copyWith(color: AppColors.appGrey5)),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Text('Nature', style: AppText.appName.copyWith(fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Text('Ambience', style: AppText.appName.copyWith(fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Text('Flowers', style: AppText.appName.copyWith(fontSize: 12.0)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Text('Description', style: AppText.appName.copyWith(color: AppColors.appGrey5)),
                  SizedBox(height: 5.0),
                  SizedBox(
                    width: 280.1,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.white, Colors.transparent],
                          stops: [0.3, 0.0, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Text(
                        'Discover the pure beauty of "Natural Essence" – your gateway to authentic, nature-inspired experiences. Let this unique collection elevate your senses and connect you with the unrefined elegance',
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.appName.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: SvgPicture.asset(AppAssets.share),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: SvgPicture.asset(AppAssets.resize),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showCategoriesDrawer = !showCategoriesDrawer;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: SvgPicture.asset(AppAssets.settingsGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
              AppButton(
                color: Colors.transparent,
                borderColor: AppColors.borderColor,
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(selectedWallpaper['id']);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    SizedBox(width: 5.0),
                    Text(
                      isFavorite ? 'Remove' : 'Save to Favorites',
                      style: AppText.appName.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              AppButton(
                color: AppColors.rainbowTextColor1,
                child: Text(
                  'Set to Wallpaper',
                  style: AppText.appName.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.baseWhite,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _desktopLayout() {
    return Consumer(
      builder: (context, ref, child) {
        final selectedWallpaper = ref.watch(selectedWallpaperProvider);
        final favorites = ref.watch(favoritesProvider);

        if (selectedWallpaper == null) {
          return Expanded(
            child: Center(
              child: Text(
                'Select a wallpaper to preview',
                style: AppText.appName.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        final isFavorite = favorites.contains(selectedWallpaper['id']);

        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.baseWhite, Colors.transparent],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              backgroundBlendMode: BlendMode.overlay,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Preview', style: AppText.cardText3.copyWith(fontSize: 32.0)),
                          SizedBox(height: 40.0),
                          Text('Name', style: AppText.appName.copyWith(color: AppColors.appGrey5)),
                          Text(
                            selectedWallpaper['name'],
                            style: AppText.cardText2.copyWith(fontSize: 24.0),
                          ),
                          SizedBox(height: 40.0),
                          Text('Tags', style: AppText.appName.copyWith(color: AppColors.appGrey5)),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text('Nature', style: AppText.appName),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text('Ambience', style: AppText.appName),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text('Flowers', style: AppText.appName),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.0),
                          Text(
                            'Description',
                            style: AppText.appName.copyWith(color: AppColors.appGrey5),
                          ),
                          SizedBox(height: 5.0),
                          SizedBox(
                            width: 280.1,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Colors.white, Colors.transparent],
                                  stops: [0.3, 0.0, 1.0],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: Text(
                                'Discover the pure beauty of "Natural Essence" – your gateway to authentic, nature-inspired experiences. Let this unique collection elevate your senses and connect you with the unrefined elegance',
                                maxLines: 5,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.appName.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 8.0,
                                  ),
                                  child: SvgPicture.asset(AppAssets.share),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 8.0,
                                  ),
                                  child: SvgPicture.asset(AppAssets.resize),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showCategoriesDrawer = !showCategoriesDrawer;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 8.0,
                                    ),
                                    child: SvgPicture.asset(AppAssets.settingsGrey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 600.99,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(width: 5.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.asset(
                                height: 600.99,
                                selectedWallpaper['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 72.36,
                                  height: 20.88,
                                  decoration: BoxDecoration(
                                    color: AppColors.baseBlack,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 84.05,
                                  height: 2.54,
                                  decoration: BoxDecoration(
                                    color: AppColors.baseWhite,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      color: Colors.transparent,
                      borderColor: AppColors.borderColor,
                      onPressed: () {
                        ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(selectedWallpaper['id']);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                          SizedBox(width: 5.0),
                          Text(
                            isFavorite ? 'Remove' : 'Save to Favorites',
                            style: AppText.appName.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.0),
                    AppButton(
                      color: AppColors.rainbowTextColor1,
                      child: Text(
                        'Set to Wallpaper',
                        style: AppText.appName.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.baseWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
