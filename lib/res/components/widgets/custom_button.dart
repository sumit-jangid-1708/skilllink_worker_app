import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool isDisabled;
  final Widget? icon;
  final IconPosition iconPosition;

  const CustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.width,
    this.height = 56, // MD3 standard large button height
    this.color,
    this.borderRadius = 16,
    this.textStyle,
    this.isDisabled = false,
    this.icon,
    this.iconPosition = IconPosition.left,
  }) : assert(
  text != null || icon != null,
  'At least one of text or icon must be provided',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: FilledButton(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: color ?? colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    final theme = Theme.of(context);

    // Icon only — no text
    if (text == null && icon != null) {
      return icon!;
    }

    // Text only — no icon
    if (icon == null) {
      return Text(
        text!,
        style: textStyle ?? theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      );
    }

    // Both icon and text
    final textWidget = Text(
      text!,
      style: textStyle ?? theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == IconPosition.left
          ? [icon!, const SizedBox(width: 8), textWidget]
          : [textWidget, const SizedBox(width: 8), icon!],
    );
  }
}

enum IconPosition { left, right }
