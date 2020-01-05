library screen_size_util;

import 'package:flutter/widgets.dart';

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder extraLarge;
  final WidgetBuilder large;
  final WidgetBuilder medium;
  final WidgetBuilder small;
  final WidgetBuilder extraSmall;
  final List<CustomBreak> breaks;

  const ResponsiveBuilder({
    Key key,
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    @required this.extraSmall,
    this.breaks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);

    if (breaks != null && breaks.isNotEmpty) {
      for (CustomBreak b in breaks) {
        if (data.satisfiesWidth(b.min, max: b.max)) {
          return b.builder(context);
        }
      }
    }

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

  bool get isExtraSmall => satisfiesWidth(0, max: 576);

  bool get isSmall => satisfiesWidth(576); //width < 768;

  bool get isMedium => satisfiesWidth(768); //width < 992;

  bool get isLarge => satisfiesWidth(992); //width < 1200;

  bool get isExtraLarge => satisfiesWidth(1200);

  bool get isExtraExtraLarge => satisfiesWidth(1600);

  bool satisfiesWidth(double min, {double max = double.maxFinite}) {
    return (isLandscape ? this.width : height) >= min &&
        (isLandscape ? this.width : height) < max;
  }

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => !isPortrait;
}

class CustomBreak {
  final double min;
  final double max;
  final WidgetBuilder builder;

  CustomBreak({
    @required this.min,
    this.max = double.maxFinite,
    @required this.builder,
  });
}
