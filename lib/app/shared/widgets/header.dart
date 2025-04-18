import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'logo.dart';
import 'menu.dart';
import 'social_buttons.dart';

PreferredSizeWidget header(key) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          key.currentState?.closeEndDrawer();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizingInformation.deviceScreenType ==
                            DeviceScreenType.desktop
                        ? const Menu()
                        : Container(),
                    const SocialButtons(),
                    sizingInformation.deviceScreenType !=
                            DeviceScreenType.desktop
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              onPressed: () =>
                                  key.currentState?.openEndDrawer(),
                              icon: Icon(
                                Icons.menu,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
