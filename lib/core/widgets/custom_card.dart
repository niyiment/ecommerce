
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.color,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final double? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Widget cardChild = Padding(
      padding: padding ?? const EdgeInsets.all(AppConstants.defaultPadding),
      child: child,
    );

    return Container(
      margin: margin,
      child: Card(
        elevation: elevation,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppConstants.borderRadius,
          ),
        ),
        child: onTap != null
            ? InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppConstants.borderRadius,
          ),
          child: cardChild,
        )
            : cardChild,
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(AppConstants.smallPadding),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
            ),
            child: Icon(
              icon,
              color: colorScheme.onPrimaryContainer,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}


