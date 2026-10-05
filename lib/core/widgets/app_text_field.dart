import '../constant/const.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? labelText;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final double borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    this.label,
    this.labelText,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.borderRadius = 12.0,
    this.borderColor,
    this.fillColor,
    this.contentPadding,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final inputTheme = Theme.of(context).inputDecorationTheme;
    final borderRadius = BorderRadius.circular(widget.borderRadius.r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          validator: widget.validator,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: widget.labelText,

            hintText: widget.hint,
            fillColor: widget.fillColor ?? inputTheme.fillColor,
            contentPadding: widget.contentPadding ?? inputTheme.contentPadding,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 20.sp, color: AppColors.primaryDark)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  )
                : widget.suffixIcon != null
                    ? Icon(widget.suffixIcon, size: 20.sp, color: AppColors.textSecondary)
                    : null,
            border: widget.borderColor != null
                ? OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: widget.borderColor!, width: 1.w),
                  )
                : (inputTheme.border is OutlineInputBorder
                    ? (inputTheme.border as OutlineInputBorder).copyWith(borderRadius: borderRadius)
                    : inputTheme.border),
            enabledBorder: widget.borderColor != null
                ? OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: widget.borderColor!, width: 1.w),
                  )
                : (inputTheme.enabledBorder is OutlineInputBorder
                    ? (inputTheme.enabledBorder as OutlineInputBorder).copyWith(borderRadius: borderRadius)
                    : inputTheme.enabledBorder),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.primary,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


