import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../provider/task_provider.dart';
import '../widgets/accept_task_modal.dart';
import '../widgets/task_card_item.dart';
import '../widgets/task_filter_chips.dart';

class QuickTechOfficeAgentTaskPage extends ConsumerWidget {
  const QuickTechOfficeAgentTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechTaskProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Tasks',
        subtitle: 'Go You Travels',
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () => RequestedTasksModal.show(context),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            LucideIcons.messageCircleDashedCheck,
            color: AppColors.surface,
            size: 24.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 80.h),
          children: [
            // 1. Filter Chips Row
            const TaskFilterChips(),
            SizedBox(height: 16.h),

            // 2. Tasks List
            if (state.filteredTasks.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 48.h),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.clipboardCheck,
                      size: 42.sp,
                      color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'No tasks found in this category',
                      style: GoogleFonts.figtree(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.filteredTasks.length,
                itemBuilder: (context, index) {
                  final item = state.filteredTasks[index];
                  return TaskCardItem(task: item);
                },
              ),

            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
