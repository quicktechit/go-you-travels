import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/task_model.dart';

class ShareTaskModal extends StatelessWidget {
  final TaskItem task;

  const ShareTaskModal({super.key, required this.task});

  static void show(BuildContext context, TaskItem task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareTaskModal(task: task),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final modalBg = isDark ? AppColors.darkSurface : AppColors.background;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final cardBg = isDark ? AppColors.darkSurfaceHigh : AppColors.surface;

    final users = [
      {'name': 'Sabrina Rahman', 'role': 'Senior Visa Consultant', 'email': 'sabrina@goyoutravels.com'},
      {'name': 'Mahmudul Hasan', 'role': 'Operations Executive', 'email': 'mahmudul@goyoutravels.com'},
      {'name': 'Tariqul Islam', 'role': 'CRM Lead Agent', 'email': 'tariqul@goyoutravels.com'},
      {'name': 'Nazmul Hossain', 'role': 'Ticketing Desk', 'email': 'nazmul@goyoutravels.com'},
      {'name': 'Farhana Yeasmin', 'role': 'Customer Support', 'email': 'farhana@goyoutravels.com'},
    ];

    return Container(
      constraints: BoxConstraints(maxHeight: 600.h),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: modalBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Share Task with User',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: primaryText,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Select a team member to share "${task.title}" with:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: secondaryText,
                ),
          ),
          SizedBox(height: 16.h),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark ? AppColors.darkLine : AppColors.line,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      child: Text(
                        user['name']![0],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      user['name']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      user['role']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: secondaryText,
                          ),
                    ),
                    trailing: AppButton(
                      width: 75.w,
                      height: 30.h,
                      text: 'Share',
                      fontSize: 12.sp,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: "Task successfully shared with ${user['name']}!",
                          toastLength: Toast.LENGTH_LONG,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
