import 'package:flutter/material.dart';

enum ReportTabFilter {
  sales('Sales'),
  leadsFunnel('Leads Funnel'),
  calling('Calling'),
  targets('Targets'),
  commissions('Commissions'),
  accounts('Accounts');

  final String label;
  const ReportTabFilter(this.label);
}

class SalesBreakdownItem {
  final String category;
  final String amountText;
  final double percentage;
  final Color color;

  const SalesBreakdownItem({
    required this.category,
    required this.amountText,
    required this.percentage,
    required this.color,
  });
}

class FunnelStageItem {
  final String percentageText;
  final String title;
  final int count;
  final Color badgeColor;

  const FunnelStageItem({
    required this.percentageText,
    required this.title,
    required this.count,
    required this.badgeColor,
  });
}

class MetricProgressItem {
  final String title;
  final String valueText;
  final double percentage;
  final Color color;

  const MetricProgressItem({
    required this.title,
    required this.valueText,
    required this.percentage,
    required this.color,
  });
}
