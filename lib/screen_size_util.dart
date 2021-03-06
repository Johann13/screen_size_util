library screen_size_util;

import 'package:flutter/widgets.dart';

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder extraLarge;
  final WidgetBuilder large;
  final WidgetBuilder medium;
  final WidgetBuilder small;
  final WidgetBuilder extraSmall;

  const ResponsiveBuilder({
    Key key,
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    @required this.extraSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    if (data.isExtraLarge && extraLarge != null) {
      return extraLarge(context);
    } else if (data.isLarge && large != null) {
      return large(context);
    } else if (data.isMedium && medium != null) {
      return medium(context);
    } else if (data.isSmall && small != null) {
      return small(context);
    }
    return extraSmall(context);
  }
}

extension SimpleMediaQueryData on MediaQueryData {
  double get height => this.size.height;

  double get width => this.size.width;

  bool get isExtraSmall => width < 576;

  bool get isSmall => width >= 576; //width < 768;

  bool get isMedium => width >= 768; //width < 992;

  bool get isLarge => width >= 992; //width < 1200;

  bool get isExtraLarge => width >= 1200;

  bool get isBigPhone {
    if (isPortrait) {
      return width >= 400;
    }
    return height >= 400;
  }

  bool get isSmallPhone {
    if (isPortrait) {
      return width <= 350;
    }
    return height <= 350;
  }

  bool get isMiddlePhone => !isBigPhone && !isSmallPhone;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => !isPortrait;
}
