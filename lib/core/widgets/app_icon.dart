import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Renders either Flutter IconData or Font Awesome FaIconData.
Widget buildIcon(
  Object? icon, {
  double size = 20,
  Color? color,
  EdgeInsetsGeometry? padding,
}) {
  if (icon == null) return const SizedBox.shrink();

  Widget iconWidget;
  if (icon is IconData) {
    iconWidget = Icon(
      icon,
      size: size,
      color: color,
    );
  } else if (icon is FaIconData) {
    iconWidget = FaIcon(
      icon,
      size: size,
      color: color,
    );
  } else {
    return const SizedBox.shrink();
  }

  if (padding != null) {
    return Padding(
      padding: padding,
      child: iconWidget,
    );
  }

  return iconWidget;
}
