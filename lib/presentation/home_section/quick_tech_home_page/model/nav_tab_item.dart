import 'package:flutter/material.dart';

class NavTabItem {
  final String label;
  final IconData icon;
  final String sfSymbol;
  final String? selectedSfSymbol;
  final Widget page;

  const NavTabItem({
    required this.label,
    required this.icon,
    required this.sfSymbol,
    this.selectedSfSymbol,
    required this.page,
  });
}
