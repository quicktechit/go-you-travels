import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../provider/task_provider.dart';

class RequestedTasksModal extends ConsumerWidget {
  const RequestedTasksModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const RequestedTasksModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechTaskProvider);
    final notifier = ref.read(quickTechTaskProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final modalBg = isDark ? AppColors.darkSurface : AppColors.background;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final cardBg = isDark ? AppColors.darkSurfaceHigh : AppColors.surface;

    return Container(
      constraints: BoxConstraints(maxHeight: 650.h),
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
                'Requested Tasks (${state.requestedTasks.length})',
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
            'Accept tasks requested by clients, managers, or colleagues.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: secondaryText,
                ),
          ),
          SizedBox(height: 16.h),
          if (state.requestedTasks.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Center(
                child: Text(
                  'No pending task requests right now.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryText,
                      ),
                ),
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.requestedTasks.length,
                itemBuilder: (context, index) {
                  final task = state.requestedTasks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkLine : AppColors.line,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color: task.priority.bgColor,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                task.priority.label,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: task.priority.textColor,
                                    ),
                              ),
                            ),
                            Text(
                              'From: ${task.requestedBy}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: secondaryText,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          task.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (task.description.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            task.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: secondaryText,
                                ),
                          ),
                        ],
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Due: ${task.dueDate} · ${task.dueTime}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 11.5.sp,
                                    color: secondaryText,
                                  ),
                            ),
                            AppButton(
                              width: 100.w,
                              height: 32.h,
                              text: 'Accept',
                              icon: LucideIcons.check,
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                notifier.acceptRequestedTask(task);
                              },
                            ),
                          ],
                        ),
                      ],
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
