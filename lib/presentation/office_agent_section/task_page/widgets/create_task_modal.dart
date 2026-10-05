import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/task_model.dart';
import '../provider/task_provider.dart';

class CreateTaskModal extends HookConsumerWidget {
  const CreateTaskModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateTaskModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(quickTechTaskProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final categoryController = useTextEditingController(text: 'Documentation');
    final dueDateController = useTextEditingController(text: 'Today');
    final dueTimeController = useTextEditingController(text: '05:00 PM');
    final selectedPriority = useState<TaskPriority>(TaskPriority.high);

    void handleSave() {
      if (titleController.text.trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please enter task title");
        return;
      }

      notifier.addTask(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        category: categoryController.text.trim(),
        priority: selectedPriority.value,
        dueDate: dueDateController.text.trim(),
        dueTime: dueTimeController.text.trim(),
      );

      Navigator.of(context).pop();
    }

    final modalBg = isDark ? AppColors.darkSurface : AppColors.background;
    final cardBg = isDark ? AppColors.darkSurfaceHigh : AppColors.surface;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final hintColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
      decoration: BoxDecoration(
        color: modalBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Assign / Create New Task',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: primaryText,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16.h),

            // Form Fields Container
            Container(
              padding: EdgeInsets.all(16.r),
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
                  // Task Title Field
                  AppTextField(
                    controller: titleController,
                    hint: 'Task Title *',
                  ),
                  SizedBox(height: 12.h),

                  // Task Description Field
                  AppTextField(
                    controller: descriptionController,
                    hint: 'Task Description',
                    maxLines: 2,
                  ),
                  SizedBox(height: 12.h),

                  // Category Field
                  Text(
                    'Category (e.g. Visa, Solvency, Calling)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: hintColor,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  AppTextField(
                    controller: categoryController,
                    hint: 'Documentation',
                  ),
                  SizedBox(height: 14.h),

                  // Priority Selector
                  Text(
                    'Priority Level',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: hintColor,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: TaskPriority.values.map((priority) {
                      final isSelected = selectedPriority.value == priority;
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: InkWell(
                          onTap: () => selectedPriority.value = priority,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: isSelected ? priority.bgColor : (isDark ? AppColors.darkSurface : AppColors.background),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: isSelected ? priority.textColor : (isDark ? AppColors.darkLine : AppColors.line),
                              ),
                            ),
                            child: Text(
                              priority.label,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? priority.textColor : hintColor,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 14.h),

                  // Due Date & Due Time Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Due Date',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: hintColor,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            AppTextField(
                              controller: dueDateController,
                              hint: 'Today',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Due Time',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: hintColor,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            AppTextField(
                              controller: dueTimeController,
                              hint: '05:00 PM',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  text: 'Cancel',
                  variant: AppButtonVariant.text,
                  textColor: AppColors.primaryDark,
                  fontSize: 14.sp,
                  onPressed: () => Navigator.of(context).pop(),
                ),

                AppButton(
                  width: 120.w,
                  text: 'Save Task',
                  onPressed: handleSave,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
