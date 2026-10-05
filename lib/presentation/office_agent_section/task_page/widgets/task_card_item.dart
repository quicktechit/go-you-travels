import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/task_model.dart';
import '../provider/task_provider.dart';

class TaskCardItem extends ConsumerWidget {
  final TaskItem task;

  const TaskCardItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(quickTechTaskProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final categoryBg = isDark ? AppColors.darkSurfaceHigh : AppColors.line;
    final categoryText = isDark ? AppColors.darkTextSecondary : AppColors.textMuted;

    final isCompleted = task.status == TaskStatus.completed;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Category Tag & Priority Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: categoryBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  task.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: categoryText,
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: task.priority.bgColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  task.priority.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                        color: task.priority.textColor,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Title
          Text(
            task.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 6.h),

          // Description
          if (task.description.isNotEmpty) ...[
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: secondaryTextColor,
                    height: 1.35,
                  ),
            ),
            SizedBox(height: 14.h),
          ],

          // Divider
          Divider(
            height: 1.h,
            color: isDark ? AppColors.darkLine : AppColors.line,
          ),
          SizedBox(height: 12.h),

          // Bottom Row: Due Time & Action Buttons / Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Due Time
              Row(
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 15.sp,
                    color: secondaryTextColor,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${task.dueDate} · ${task.dueTime}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                          color: secondaryTextColor,
                        ),
                  ),
                ],
              ),

              // Action Buttons or Completed Badge
              if (isCompleted)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.secondaryDark.withValues(alpha: 0.3) : AppColors.secondaryLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Completed',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.secondaryLight : AppColors.secondaryDark,
                        ),
                  ),
                )
              else
                Row(
                  children: [
                    // Start Button
                    if (task.status == TaskStatus.pending) ...[
                      AppButton(
                        width: 80.w,
                        text: 'Start',
                        variant: AppButtonVariant.outlined,
                        height: 32.h,
                        fontSize: 12.sp,
                        horizontalPadding: 14.w,
                        color: isDark ? AppColors.darkLine : AppColors.line,
                        textColor: AppColors.primaryDark,
                        onPressed: () => notifier.startTask(task.id),
                      ),
                      SizedBox(width: 8.w),
                    ],

                    // Done Button
                    AppButton(
                      text: 'Done',       width: 80.w,
                      icon: LucideIcons.check,
                      variant: AppButtonVariant.primary,
                      height: 32.h,
                      fontSize: 12.sp,
                      horizontalPadding: 12.w,
                      backgroundColor: AppColors.secondaryDark,
                      onPressed: () => notifier.completeTask(task.id),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
