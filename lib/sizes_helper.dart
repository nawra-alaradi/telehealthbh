import 'package:flutter/material.dart';

Size getScreenSize(BuildContext context) {
  //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double getAllHeight(BuildContext context) {
  // debugPrint('Height = ' + displaySize(context).height.toString());
  return getScreenSize(context).height;
}

double getHMinusStat(BuildContext context) {
  // debugPrint('Height minus statusbar = ' +
  //     (displaySize(context).height - MediaQuery.of(context).padding.top)
  //         .toString());
  return getScreenSize(context).height - MediaQuery.of(context).padding.top;
}

double getHMinusAppbar(BuildContext context) {
  // debugPrint('Height minus appbar = ' +
  //     (displayHeightMinusStatusbar(context) - kTextTabBarHeight).toString());
  return getHMinusStat(context) - kTextTabBarHeight;
}

double getWidth(BuildContext context) {
  // debugPrint('Width = ' + displaySize(context).width.toString());
  return getScreenSize(context).width;
}
