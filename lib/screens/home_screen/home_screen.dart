import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/app_text.dart';
import '../../utilities/providers/providers.dart';
import '../../utilities/reusable_list/grid_card.dart';
import '../../utilities/screen_sizing/screen_sizing.dart';
import '../../utilities/widgets/rainbow_text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDesktop = ScreenSizing.isDesktop(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RainbowText('Discover Beautiful Wallpapers'),
          const SizedBox(height: 10.0),
          SizedBox(
            width: isDesktop ? 870.0 : 350.0,
            child: Text(
              'Discover curated collections of stunning wallpapers. Browse by category, preview in full-screen, and set your favorites.',
              style: AppText.appName.copyWith(
                fontSize: isDesktop ? 24.0 : 16.0,
                color: AppColors.appGrey2,
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: AppText.rainbowText.copyWith(
                  color: AppColors.baseBlack,
                  fontSize: isDesktop ? 32.0 : 20.0,
                ),
              ),
              TextButton(
                onPressed: () => ref.read(navigationIndexProvider.notifier).state = 1,
                child: Text(
                  'See all',
                  style: AppText.appName.copyWith(
                    fontSize: isDesktop ? 24.0 : 16.0,
                    color: AppColors.appGrey2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridCard.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: isDesktop ? 1.5 : 1.2,
            ),
            itemBuilder: (context, index) {
              return gridCard[index];
            },
          ),
        ],
      ),
    );
  }
}
