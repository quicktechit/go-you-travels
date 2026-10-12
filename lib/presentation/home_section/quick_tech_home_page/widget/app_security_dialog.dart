import '../../../../core/constant/const.dart';

class AppSecurityDialog extends StatefulWidget {
  final String correctSecretKey;
  final VoidCallback? onUnlocked;

  const AppSecurityDialog({
    super.key,
    this.correctSecretKey = '123456',
    this.onUnlocked,
  });

  /// Helper method to show this blocking security dialog anywhere in the app
  static Future<void> show(
    BuildContext context, {
    String correctSecretKey = '123456',
    VoidCallback? onUnlocked,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppSecurityDialog(
        correctSecretKey: correctSecretKey,
        onUnlocked: onUnlocked,
      ),
    );
  }

  @override
  State<AppSecurityDialog> createState() => _AppSecurityDialogState();
}

class _AppSecurityDialogState extends State<AppSecurityDialog> {
  final TextEditingController _keyController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  void _validateAndUnlock() {
    final enteredKey = _keyController.text.trim();
    if (enteredKey.isEmpty) {
      setState(() {
        _errorMessage = 'Secret key cannot be empty';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate verification delay
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      if (enteredKey == widget.correctSecretKey) {
        Fluttertoast.showToast(
          msg: 'App unlocked successfully!',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.of(context).pop();
        if (widget.onUnlocked != null) {
          widget.onUnlocked!();
        }
      } else {
        setState(() {
          _errorMessage = 'Incorrect secret key. Access denied.';
        });
        Fluttertoast.showToast(
          msg: 'Incorrect secret key',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Completely blocks back button and gesture dismissal
      child: Dialog(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: Colors.redAccent.withValues(alpha: 0.5),
            width: 1.5.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Warning Icon Header
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_person_rounded,
                    size: 48.sp,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 16.h),

                // Title
                Text(
                  'App Blocked & Restricted',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,

                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),

                // Description
                Text(
                  'Security restriction active. You cannot interact with or use the app until the correct secret key is entered.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),

                // Secret Key Text Field
                AppTextField(
                  controller: _keyController,
                  label: 'Secret Key',
                  hint: 'Enter secret security key',
                  isPassword: true,
                  prefixIcon: Icons.key_rounded,
                  borderColor: _errorMessage != null ? Colors.redAccent : null,
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() {
                        _errorMessage = null;
                      });
                    }
                  },
                ),

                if (_errorMessage != null) ...[
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],

                SizedBox(height: 24.h),

                // Unlock Button
                AppButton(
                  text: 'Unlock App',
                  isLoading: _isLoading,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: _validateAndUnlock,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
