import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass/liquid_glass.dart';

import '../../screens/categories/categories_screen.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../providers/providers.dart';
import '../screen_sizing/screen_sizing.dart';

class ListCardWidget extends ConsumerWidget {
  const ListCardWidget({
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
    final bool isDesktop = ScreenSizing.isDesktop(context);
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
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Container(
              width: isDesktop ? 277.21 : 150.0,
              height: isDesktop ? 185.12 : 150.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            SizedBox(width: 15.0),
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: isDesktop ? AppText.cardText2 : AppText.cardText3),
                Text(subtitle, style: AppText.appName.copyWith(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      liquidText,
                      style: AppText.appName.copyWith(color: AppColors.baseBlack),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({
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
    final bool isDesktop = ScreenSizing.isDesktop(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            width: isDesktop ? 267.21 : 140.0,
            height: isDesktop ? 175.12 : 140.0,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.only(top: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              ),
            ),
            child: Align(
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
          ),
          SizedBox(width: 15.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(textNumber, style: AppText.appName.copyWith(fontSize: 24.0)),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.appGrey3.withAlpha((0.1 * 250).toInt()),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    'Nature',
                    style: AppText.appName.copyWith(color: AppColors.baseBlack),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
