import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass/liquid_glass.dart';
import '../../screens/categories/categories_screen.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../providers/providers.dart';

class GridCardWidget extends ConsumerWidget {
  const GridCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.liquidText,
  });

  final String image;
  final String title;
  final String subtitle;
  final String liquidText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final currentIndex = ref.read(navigationIndexProvider);

        if (currentIndex != 1) {
          // Change to Browse tab (index 1) first
          ref.read(navigationIndexProvider.notifier).state = 1;

          // Wait for tab switch, then trigger navigation
          Future.delayed(const Duration(milliseconds: 200), () {
            ref.read(browseCategoriesNavigationProvider.notifier).state = true;
          });
        } else {
          // Already on Browse tab, navigate directly
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CategoriesScreen()));
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.cardText1),
              Text(
                subtitle,
                style: AppText.appName.copyWith(color: AppColors.baseWhite, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              LiquidGlass(
                blur: 1.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    liquidText,
                    style: AppText.appName.copyWith(color: AppColors.baseWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    super.key,
    required this.onTap,
    required this.isFavorite,
    required this.image,
    required this.textNumber,
  });

  final void Function()? onTap;
  final bool isFavorite;
  final String image;
  final String textNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onTap,
              child: LiquidGlass(
                blur: 1.0,
                opacity: isFavorite ? 10.0 : 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.favoriteColor : AppColors.baseWhite,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textNumber,
                  style: AppText.appName.copyWith(color: AppColors.baseWhite, fontSize: 24.0),
                ),
                LiquidGlass(
                  blur: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
                    child: Text(
                      'Nature',
                      style: AppText.appName.copyWith(color: AppColors.baseWhite),
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
