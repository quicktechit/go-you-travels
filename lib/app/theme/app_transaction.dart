import 'package:flutter/material.dart';


class TimedFadePageTransitionsBuilder extends PageTransitionsBuilder {
  final Duration duration;
  final Duration reverseDuration;

  const TimedFadePageTransitionsBuilder({
    this.duration = const Duration(milliseconds: 700),
    this.reverseDuration = const Duration(milliseconds: 600),
  });

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.slowMiddle,
      ),
      child: child,
    );
  }
}