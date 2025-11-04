import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_studio/utilities/screen_sizing/screen_sizing.dart';
import 'package:wallpaper_studio/utilities/widgets/app_button.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';

class CategoriesDrawer extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onClose;

  const CategoriesDrawer({super.key, required this.isVisible, required this.onClose});

  @override
  State<CategoriesDrawer> createState() => _CategoriesDrawerState();
}

class _CategoriesDrawerState extends State<CategoriesDrawer> {
  String selectedDisplayMode = 'Fit';
  bool autoRotation = true;

  bool lockWallpaper = true;
  bool syncAcrossDevices = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    final isDesktop = ScreenSizing.isDesktop(context);
    return Stack(
      children: [
        if (widget.isVisible)
          Positioned.fill(
            child: GestureDetector(
              onTap: widget.onClose,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withAlpha((0.3).toInt())),
              ),
            ),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          right: widget.isVisible ? 0 : -width,
          child: Material(
            elevation: 10,
            color: AppColors.baseWhite,
            child: SizedBox(
              width: width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Wallpaper Setup', style: AppText.cardText2.copyWith(fontSize: 24.0)),
                    SizedBox(height: 10.0),
                    Text(
                      'Configure your wallpaper settings and enable auto-rotation',
                      style: AppText.appName,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: isDesktop
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Activate Wallpaper',
                                      style: AppText.cardText2.copyWith(fontSize: 20.0),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.appGreen,
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(AppAssets.tick),
                                          SizedBox(width: 10.0),
                                          Text(
                                            'Activated',
                                            style: AppText.appName.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.appGreenText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 276.79,
                                  child: Text(
                                    'Set the selected wallpaper as your desktop background',
                                    style: AppText.appName.copyWith(color: AppColors.appGrey6),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Activate Wallpaper',
                                  style: AppText.cardText2.copyWith(fontSize: 20.0),
                                ),
                                SizedBox(height: 10.0),
                                SizedBox(
                                  width: 276.79,
                                  child: Text(
                                    'Set the selected wallpaper as your desktop background',
                                    style: AppText.appName.copyWith(color: AppColors.appGrey6),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.appGreen,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(AppAssets.tick),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Activated',
                                        style: AppText.appName.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.appGreenText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 20.0),
                    Text('Display Mode', style: AppText.appName.copyWith(fontSize: 20.0)),
                    const SizedBox(height: 16),
                    _buildDisplayModeOption('Fit', 'Scale to fit without cropping'),
                    _buildDisplayModeOption('Fill', 'Scale to fill the entire screen'),
                    _buildDisplayModeOption('Stretch', 'Stretch to fill the screen'),
                    _buildDisplayModeOption('Tile', 'Repeat the image to fill the screen'),
                    const SizedBox(height: 32),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.appGrey7),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Auto - Rotation',
                                  style: AppText.cardText2.copyWith(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Automatically change your wallpaper at regular intervals',
                                  style: AppText.appName.copyWith(color: AppColors.appGrey6),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: autoRotation,
                            onChanged: (value) {
                              setState(() {
                                autoRotation = value;
                              });
                            },
                            activeThumbColor: AppColors.baseWhite,
                            activeTrackColor: AppColors.rainbowTextColor1,
                            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    Text('Advanced Settings', style: AppText.appName.copyWith(fontSize: 20.0)),
                    const SizedBox(height: 16),
                    _buildAdvancedOption(
                      'Lock Wallpaper',
                      'Prevent accidental changes',
                      lockWallpaper,
                      () {
                        setState(() {
                          lockWallpaper = !lockWallpaper;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildAdvancedOption(
                      'Sync Across Devices',
                      'Keep wallpaper consistent on all devices',
                      syncAcrossDevices,
                      () {
                        setState(() {
                          syncAcrossDevices = !syncAcrossDevices;
                        });
                      },
                    ),
                    SizedBox(height: 50.0),
                    isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppButton(
                                color: AppColors.appBackgroundColor,
                                borderColor: AppColors.borderColor,
                                child: Text(
                                  'Cancel',
                                  style: AppText.appName.copyWith(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              AppButton(
                                color: AppColors.rainbowTextColor1,
                                child: Text(
                                  'Save Settings',
                                  style: AppText.appName.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.baseWhite,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                              children: [
                                AppButton(
                                  width: double.infinity,
                                  color: AppColors.appBackgroundColor,
                                  borderColor: AppColors.borderColor,
                                  child: Text(
                                    'Cancel',
                                    style: AppText.appName.copyWith(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                AppButton(
                                  width: double.infinity,
                                  color: AppColors.rainbowTextColor1,
                                  child: Text(
                                    'Save Settings',
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisplayModeOption(String title, String subtitle) {
    bool isSelected = selectedDisplayMode == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDisplayMode = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.appGrey7, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.rainbowTextColor1 : AppColors.appGrey8,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.rainbowTextColor1,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.cardText2.copyWith(fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppText.appName.copyWith(color: AppColors.appGrey6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedOption(String title, String subtitle, bool value, Function() onTap) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.appGrey8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 24.0,
              height: 24.0,
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(border: Border.all(color: value ? AppColors.rainbowTextColor1 : AppColors.appGrey8,),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child:  Container(
                decoration: BoxDecoration(color: value ? AppColors.rainbowTextColor1 : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.cardText2.copyWith(fontSize: 16)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppText.appName.copyWith(color: AppColors.appGrey6)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
