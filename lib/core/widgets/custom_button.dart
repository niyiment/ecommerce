

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ?
      const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        )
      ) : icon != null ?
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8,),
          Text(text),
          ],
      ) : Text(text),
    );
    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}


class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ?
       SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).primaryColor
            ),
          )
      ) : icon != null ?
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8,),
          Text(text),
        ],
      ) : Text(text),
    );
    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}


class IconButtonWithBackground extends StatelessWidget {
  const IconButtonWithBackground({
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 48.0,
    super.key
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor ?? colorScheme.onPrimaryContainer),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

