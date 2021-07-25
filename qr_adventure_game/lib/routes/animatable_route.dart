import 'package:flutter/material.dart';

class AnimatableRoute<T> extends MaterialPageRoute<T> {
  /// Descendent of MaterialPageRoute that enables control over the animations.
  AnimatableRoute({WidgetBuilder? builder, RouteSettings? settings})
      : super(builder: builder!, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}