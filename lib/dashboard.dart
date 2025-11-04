import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_studio/screens/browse_screen/browse_screen.dart';
import 'package:wallpaper_studio/screens/favorites_screen/favorites_screen.dart';
import 'package:wallpaper_studio/screens/home_screen/home_screen.dart';
import 'package:wallpaper_studio/screens/settings_screen/settings_screen.dart';
import 'package:wallpaper_studio/utilities/constants/app_assets.dart';
import 'package:wallpaper_studio/utilities/constants/app_colors.dart';
import 'package:wallpaper_studio/utilities/constants/app_text.dart';
import 'package:wallpaper_studio/utilities/providers/providers.dart';
import 'package:wallpaper_studio/utilities/screen_sizing/screen_sizing.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  static final List<AppNavigationItem> destinations = [
    AppNavigationItem(icon: AppAssets.home, label: 'Home', page: HomeScreen()),
    AppNavigationItem(icon: AppAssets.browse, label: 'Browse', page: BrowseScreen()),
    AppNavigationItem(icon: AppAssets.favorites, label: 'Favorites', page: FavoritesScreen()),
    AppNavigationItem(icon: AppAssets.settings, label: 'Settings', page: SettingsScreen()),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: AppColors.baseWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              ...List.generate(destinations.length, (index) {
                final item = destinations[index];
                return Column(
                  children: [
                    AppBarNav(
                      icon: item.icon,
                      name: item.label,
                      isActive: selectedIndex == index,
                      onTap: () {
                        final currentIndex = ref.read(navigationIndexProvider);

                        // If leaving Browse tab (index 1), clear its stack
                        if (currentIndex == 1 && index != 1) {
                          ref.read(clearBrowseStackProvider.notifier).state = true;
                        }

                        ref.read(navigationIndexProvider.notifier).state = index;
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Material(
            elevation: 1.0,
            child: Container(
              color: AppColors.baseWhite,
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.logo),
                      const SizedBox(width: 10.0),
                      Text('Wallpaper Studio', style: AppText.appName),
                    ],
                  ),

                  ScreenSizing.isDesktop(context) ? _desktopView(ref, selectedIndex, destinations) : _tabletView(),
                ],
              ),
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: destinations.map(
                    (dest) => Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => dest.page,
                    );
                  },
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabletView() {
    return Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset(AppAssets.hamburger),
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
      ),
    );
  }

  Widget _desktopView(WidgetRef ref, int selectedIndex, List<AppNavigationItem> destinations) {
    return Row(
      children: List.generate(destinations.length, (index) {
        final item = destinations[index];
        return GestureDetector(
          onTap: () {
            final currentIndex = ref.read(navigationIndexProvider);

            // If leaving Browse tab (index 1), clear its stack
            if (currentIndex == 1 && index != 1) {
              ref.read(clearBrowseStackProvider.notifier).state = true;
            }

            ref.read(navigationIndexProvider.notifier).state = index;
          },
          child: AppBarNav(icon: item.icon, name: item.label, isActive: selectedIndex == index),
        );
      }),
    );
  }
}

class AppBarNav extends StatelessWidget {
  const AppBarNav({
    super.key,
    required this.icon,
    required this.name,
    this.isActive = false,
    this.onTap,
  });

  final String icon;
  final String name;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: isActive ? AppColors.appGrey : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.baseBlack : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              name,
              style: AppText.appName.copyWith(color: isActive ? AppColors.baseBlack : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class AppNavigationItem {
  final String label;
  final String icon;
  final Widget page;

  const AppNavigationItem({required this.label, required this.icon, required this.page});
}
