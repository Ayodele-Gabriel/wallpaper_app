import 'package:flutter/material.dart';
import 'package:wallpaper_studio/utilities/constants/app_assets.dart';

import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/app_text.dart';
import '../../utilities/screen_sizing/screen_sizing.dart';
import '../../utilities/widgets/app_button.dart';
import '../../utilities/widgets/rainbow_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notification = true;
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenSizing.isDesktop(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RainbowText('Settings'),
          const SizedBox(height: 10.0),
          Text(
            'Customize your Wallpaper Studio experience',
            style: AppText.appName.copyWith(
              fontSize: 24.0,
              color: AppColors.appGrey2,
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            padding: EdgeInsets.only(left: isDesktop ? 0.0 : 30.0, right: isDesktop ? 200.0 : 30.0, top: 30.0, bottom: 30.0),
            decoration: BoxDecoration(
              color: AppColors.baseWhite,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                        width: isDesktop ? 529.0 : null,
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
                            SizedBox(height: 20.0),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: AppColors.borderColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Image Quality', style: AppText.appName.copyWith(fontSize: 20.0)),
                                  SizedBox(height: 5.0),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: AppColors.borderColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'High ( Best Quality )',
                                          style: AppText.appName.copyWith(color: AppColors.appGrey6),
                                        ),
                                        Icon(Icons.keyboard_arrow_down),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: AppColors.borderColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Notification', style: AppText.appName.copyWith(fontSize: 20.0)),
                                      Switch(
                                        value: notification,
                                        onChanged: (value) {
                                          setState(() {
                                            notification = value;
                                          });
                                        },
                                        activeThumbColor: AppColors.baseWhite,
                                        activeTrackColor: AppColors.rainbowTextColor1,
                                        trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Get notified about new wallpapers and updates',
                                    style: AppText.appName.copyWith(color: AppColors.appGrey6),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  width: 200.0,
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
                                  width: 200.0,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox( width: 50.0,),
                Image.asset(AppAssets.phone2, width: 230.51),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
