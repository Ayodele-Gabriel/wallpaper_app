import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../utilities/constants/app_assets.dart';
import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/app_text.dart';
import '../../utilities/providers/providers.dart';
import '../../utilities/reusable_list/grid_card.dart';
import '../../utilities/reusable_list/list_card.dart';
import '../../utilities/screen_sizing/screen_sizing.dart';
import '../../utilities/widgets/rainbow_text.dart';
import '../categories/categories_screen.dart';

class BrowseScreen extends ConsumerStatefulWidget {
  const BrowseScreen({super.key});

  @override
  ConsumerState<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends ConsumerState<BrowseScreen> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenSizing.isDesktop(context);

    ref.listen(clearBrowseStackProvider, (previous, next) {
      if (next == true) {
        // Pop all routes except the first one (the Browse screen itself)
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        // Reset the trigger
        Future.microtask(() {
          ref.read(clearBrowseStackProvider.notifier).state = false;
        });
      }
    });

    // Listen for navigation to categories
    ref.listen(browseCategoriesNavigationProvider, (previous, next) {
      if (next == true && previous == false) {
        // Reset immediately
        Future.microtask(() {
          ref.read(browseCategoriesNavigationProvider.notifier).state = false;
        });

        // Navigate to categories
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CategoriesScreen()),
            );
          }
        });
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RainbowText('Browse Categories'),
          const SizedBox(height: 10.0),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore our curated collections of stunning wallpapers',
                style: AppText.appName.copyWith(
                  fontSize: isDesktop ? 24.0 : 16.0,
                  color: AppColors.appGrey2,
                ),
              ),
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
          const SizedBox(height: 30.0),

          !toggle
              ? GridView.builder(
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
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listCard.length,
                  itemBuilder: (context, index) {
                    return Flex(
                      direction: Axis.vertical,
                      children: [
                        listCard[index],
                        Divider(),
                      ],
                    );
                  },
                ),
        ],
      ),
    );
  }
}
