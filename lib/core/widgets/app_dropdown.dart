import '../constant/const.dart';

class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final Widget? labelWidget;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Color? dropdownColor;
  final double? itemHeight;
  final bool isExpanded;

  const AppDropdown({
    super.key,
    this.label,
    this.labelWidget,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.prefixIconColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.contentPadding,
    this.selectedItemBuilder,
    this.dropdownColor,
    this.itemHeight,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final inputTheme = Theme.of(context).inputDecorationTheme;
    final radius = BorderRadius.circular(borderRadius.r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelWidget != null) ...[
          labelWidget!,
          SizedBox(height: 8.h),
        ] else if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 8.h),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          onChanged: onChanged,
          items: items,
          selectedItemBuilder: selectedItemBuilder,
          dropdownColor: dropdownColor,
          itemHeight: itemHeight,
          isExpanded: isExpanded,
          validator: validator,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: contentPadding ?? inputTheme.contentPadding,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 20.sp,
                    color: prefixIconColor ?? AppColors.primaryDark,
                  )
                : null,
            border: _widgetBorder(context, radius),
            enabledBorder: _widgetBorder(context, radius),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: borderColor ?? AppColors.primary,
                width: 1.5.w,
              ),
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: AppColors.textSecondary,
            size: 26.sp,
          ),
          borderRadius: radius,
        ),
      ],
    );
  }

  InputBorder _widgetBorder(BuildContext context, BorderRadius radius) {
    if (borderColor != null) {
      return OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: borderColor!, width: 1.5.w),
      );
    }
    final inputTheme = Theme.of(context).inputDecorationTheme;
    if (inputTheme.border is OutlineInputBorder) {
      return (inputTheme.border as OutlineInputBorder).copyWith(borderRadius: radius);
    }
    return OutlineInputBorder(borderRadius: radius);
  }
}


