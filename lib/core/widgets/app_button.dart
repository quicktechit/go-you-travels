import '../constant/const.dart';

enum AppButtonVariant { primary, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final IconData? trailingIcon;
  final AppButtonVariant variant;
  final double? width;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize; // Added dynamic font size
  final double? horizontalPadding; // Added dynamic horizontal padding
  final double? verticalPadding; // Added dynamic vertical padding

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.trailingIcon,
    this.variant = AppButtonVariant.primary,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
    this.gradient,
    this.boxShadow,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 52.h;
    final radius = borderRadius ?? 12.r;
    final effectiveFontSize = fontSize ?? 16.sp;
    final effectiveHorizontalPadding = horizontalPadding ?? 12.w; // Reduced from 16 to 12
    final effectiveVerticalPadding = verticalPadding ?? 8.h; // Reduced from 12 to 8

    switch (variant) {
      case AppButtonVariant.primary:
        Widget button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? (gradient != null ? Colors.transparent : (color ?? AppColors.primary)),
            shadowColor: gradient != null ? Colors.transparent : null,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            elevation: boxShadow != null ? 0 : null,
            minimumSize: const Size(0, 0),
            padding: EdgeInsets.symmetric(
              horizontal: effectiveHorizontalPadding,
              vertical: effectiveVerticalPadding,
            ),
          ),
          child: _buildChild(
            context,
            textColor ?? Colors.white,
            effectiveFontSize,
          ),
        );

        if (gradient != null || boxShadow != null) {
          return Container(
            width: width ?? double.infinity,
            height: effectiveHeight,
            decoration: BoxDecoration(
              gradient: gradient,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: button,
          );
        }

        return SizedBox(
          width: width ?? double.infinity,
          height: effectiveHeight,
          child: button,
        );

      case AppButtonVariant.outlined:
        final borderColor = color ?? AppColors.primary;
        final textColorValue = textColor ?? borderColor;

        return SizedBox(
          width: width ?? double.infinity,
          height: effectiveHeight,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: borderColor,
                width: 1.5.w,
              ),
              backgroundColor: backgroundColor ?? color?.withValues(alpha: 0.1),
              foregroundColor: textColorValue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: effectiveHorizontalPadding,
                vertical: effectiveVerticalPadding,
              ),
            ),
            child: _buildChild(context, textColorValue, effectiveFontSize),
          ),
        );

      case AppButtonVariant.text:
        final textColorValue = textColor ?? (color ?? AppColors.primary);

        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColorValue,
            padding: EdgeInsets.symmetric(
              horizontal: effectiveHorizontalPadding,
              vertical: effectiveVerticalPadding,
            ),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: _buildChild(context, textColorValue, effectiveFontSize),
        );
    }
  }

  Widget _buildChild(BuildContext context, Color contentColor, double fontSize) {
    if (isLoading) {
      return SizedBox(
        height: 20.h,
        width: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(contentColor),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: fontSize * 1.2, // Icon size relative to font size
            color: contentColor,
          ),
          SizedBox(width: 6.w), // Reduced from 8 to 6
        ],
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: contentColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize, // Dynamic font size
            letterSpacing: 0.3, // Slightly reduced from 0.5
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: 6.w),
          Icon(
            trailingIcon,
            size: fontSize * 1.2,
            color: contentColor,
          ),
        ],
      ],
    );
  }
}