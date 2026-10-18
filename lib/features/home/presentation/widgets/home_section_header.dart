import 'package:flutter/material.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
